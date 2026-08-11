import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:uuid/uuid.dart';

import '../config/app_config.dart';
import '../database/archive_database.dart'
    hide
        BibleVerse,
        DocumentBlock,
        ScriptureReferenceSegment,
        ScriptureReferenceSpan;
import '../domain/archive_models.dart';
import '../scripture/scripture_reference_parser.dart';
import 'contracts.dart';
import 'disk_space_service.dart';

class ArchiveRepository
    implements
        CatalogueRepository,
        LibraryRepository,
        DocumentRepository,
        SearchRepository,
        DownloadRepository,
        StudyRepository,
        SettingsRepository {
  ArchiveRepository(
    this._databases,
    this._config, {
    Dio? dio,
    DiskSpaceService? diskSpace,
    ScriptureReferenceParser? scriptureParser,
  }) : _dio =
           dio ?? Dio(BaseOptions(connectTimeout: const Duration(seconds: 10))),
       _diskSpace = diskSpace ?? const DeviceDiskSpaceService(),
       _scriptureParser = scriptureParser ?? ScriptureReferenceParser();

  final DatabaseBundle _databases;
  final AppConfig _config;
  final Dio _dio;
  final DiskSpaceService _diskSpace;
  final ScriptureReferenceParser _scriptureParser;
  final Uuid _uuid = const Uuid();
  final Set<String> _cancelledCollections = <String>{};
  ArchiveCatalogue? _catalogue;
  var _backgroundRefreshStarted = false;
  Future<void>? _scriptureIndexReady;

  @override
  Future<ArchiveCatalogue> loadCatalogue({bool forceRefresh = false}) async {
    if (!forceRefresh && _catalogue != null) return _catalogue!;
    final cached = await _readCachedCatalogue();
    if (!forceRefresh && cached != null) {
      _catalogue = cached.$1;
      return cached.$1;
    }
    if (_config.catalogueUrl.isEmpty) {
      throw StateError('No archive catalogue is configured.');
    }
    try {
      return await _refreshCatalogue(etag: cached?.$2);
    } catch (_) {
      if (cached != null) {
        _catalogue = cached.$1;
        return cached.$1;
      }
      rethrow;
    }
  }

  Future<(ArchiveCatalogue, String?)?> _readCachedCatalogue() async {
    final row = await _databases.app
        .customSelect(
          'SELECT catalogue_json, etag FROM catalogue_cache WHERE id = 1',
        )
        .getSingleOrNull();
    if (row == null) return null;
    try {
      final catalogue = ArchiveCatalogue.decode(
        row.read<String>('catalogue_json'),
      );
      if (catalogue.developmentFixture) return null;
      return (catalogue, row.readNullable<String>('etag'));
    } on FormatException {
      return null;
    }
  }

  Future<ArchiveCatalogue> _refreshCatalogue({String? etag}) async {
    try {
      final response = await _dio.get<String>(
        _config.catalogueUrl,
        options: Options(
          responseType: ResponseType.plain,
          headers: etag == null
              ? null
              : <String, Object?>{'if-none-match': etag},
          validateStatus: (status) => status == 200 || status == 304,
        ),
      );
      if (response.statusCode == HttpStatus.notModified) {
        final cached = await _readCachedCatalogue();
        if (cached == null) {
          throw const FormatException(
            'Catalogue returned 304 without a cache.',
          );
        }
        _catalogue = cached.$1;
        return cached.$1;
      }
      final body = response.data;
      if (body == null) throw const FormatException('Empty catalogue');
      final parsed = ArchiveCatalogue.decode(body);
      if (parsed.developmentFixture) {
        throw const FormatException(
          'Development content catalogues are not supported by this app.',
        );
      }
      await _databases.app.customStatement(
        'INSERT OR REPLACE INTO catalogue_cache '
        '(id, catalogue_json, etag, fetched_at) VALUES (1, ?, ?, ?)',
        <Object?>[
          body,
          response.headers.value('etag'),
          DateTime.now().toUtc().toIso8601String(),
        ],
      );
      _catalogue = parsed;
      return parsed;
    } catch (_) {
      // Background refreshes must never create an unhandled asynchronous error.
      final cached = await _readCachedCatalogue();
      if (cached != null) return cached.$1;
      rethrow;
    }
  }

  @override
  Future<List<CollectionSummary>> getCollections() async =>
      (await loadCatalogue()).collections;

  Future<bool> refreshCatalogueInBackgroundOnce() async {
    if (_backgroundRefreshStarted || _config.catalogueUrl.isEmpty) return false;
    _backgroundRefreshStarted = true;
    final before = _catalogue ?? (await _readCachedCatalogue())?.$1;
    try {
      final after = await loadCatalogue(forceRefresh: true);
      return before == null ||
          before.catalogueVersion != after.catalogueVersion ||
          before.collections.map((item) => item.id).join('|') !=
              after.collections.map((item) => item.id).join('|');
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String> getStoragePath() async =>
      (await getApplicationSupportDirectory()).path;

  @override
  Future<int> updateDownloadedCollections() async {
    final previous = _catalogue ?? (await _readCachedCatalogue())?.$1;
    final catalogue = await loadCatalogue(forceRefresh: true);
    final available = <String, CollectionSummary>{
      for (final collection in catalogue.collections) collection.id: collection,
    };
    final installedRows = await _databases.app
        .customSelect(
          'SELECT collection_id, content_version, state FROM downloaded_collections',
        )
        .get();
    var updates = 0;
    for (final row in installedRows) {
      final id = row.read<String>('collection_id');
      final remote = available[id];
      if (remote == null || row.read<String>('state') == 'downloading') {
        continue;
      }
      var updateAvailable =
          remote.contentVersion > row.read<int>('content_version');
      if (!updateAvailable && remote.manifestPath != null) {
        try {
          final manifest = await _loadPublishedManifest(remote);
          final fingerprint = _manifestFingerprint(manifest);
          final installedFingerprint = await getValue(
            'collection_fingerprint:$id',
          );
          if (installedFingerprint != null) {
            updateAvailable = installedFingerprint != fingerprint;
          } else if (manifest['documents'] is List) {
            final installedCount = await _databases.archive
                .customSelect(
                  'SELECT COUNT(*) AS count FROM documents WHERE collection_id = ?',
                  variables: <Variable<Object>>[Variable<String>(id)],
                )
                .getSingle();
            updateAvailable =
                installedCount.read<int>('count') !=
                (manifest['documents']! as List).length;
          }
        } catch (_) {
          // A failed per-collection probe must not hide other catalogue updates.
        }
      }
      if (updateAvailable) {
        await _databases.app.customStatement(
          "UPDATE downloaded_collections SET state = 'update_available', error_message = NULL WHERE collection_id = ?",
          <Object?>[id],
        );
        updates++;
      }
    }
    final previousIds =
        previous?.collections.map((item) => item.id).toSet() ??
        const <String>{};
    final discovered = catalogue.collections
        .where((item) => !previousIds.contains(item.id))
        .length;
    final catalogueChanged =
        previous != null &&
        previous.catalogueVersion != catalogue.catalogueVersion;
    return updates +
        discovered +
        (catalogueChanged && updates + discovered == 0 ? 1 : 0);
  }

  @override
  Future<Set<String>> getInstalledCollectionIds() async {
    final rows = await _databases.archive
        .customSelect('SELECT id FROM archive_collections')
        .get();
    return rows.map((row) => row.read<String>('id')).toSet();
  }

  @override
  Future<Map<String, String>> getDownloadStates() async {
    final rows = await _databases.app
        .customSelect('SELECT collection_id, state FROM downloaded_collections')
        .get();
    return <String, String>{
      for (final row in rows)
        row.read<String>('collection_id'): row.read<String>('state'),
    };
  }

  Future<Map<String, DownloadJob>> getDownloadJobs() async {
    final rows = await _databases.app
        .customSelect('SELECT * FROM downloaded_collections')
        .get();
    return <String, DownloadJob>{
      for (final row in rows)
        row.read<String>('collection_id'): DownloadJob(
          collectionId: row.read<String>('collection_id'),
          contentVersion: row.read<int>('content_version'),
          state: row.read<String>('state'),
          downloadedBytes: row.read<int>('downloaded_bytes'),
          totalBytes: row.read<int>('total_bytes'),
          errorMessage: row.readNullable<String>('error_message'),
        ),
    };
  }

  @override
  Future<List<ArchiveDocument>> getDocuments(String collectionId) async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT * FROM documents WHERE collection_id = ? '
          'ORDER BY sort_order ASC, COALESCE(part_number, 0) ASC',
          variables: <Variable<Object>>[Variable<String>(collectionId)],
        )
        .get();
    final documents = <ArchiveDocument>[];
    for (final row in rows) {
      documents.add(await _documentFromRow(row.data));
    }
    return documents;
  }

  @override
  Future<ArchiveDocument?> getDocument(String id) async {
    final row = await _databases.archive
        .customSelect(
          'SELECT * FROM documents WHERE id = ?',
          variables: <Variable<Object>>[Variable<String>(id)],
        )
        .getSingleOrNull();
    return row == null ? null : _documentFromRow(row.data);
  }

  Future<ArchiveDocument> _documentFromRow(Map<String, Object?> data) async {
    final assetRows = await _databases.archive
        .customSelect(
          'SELECT * FROM document_files WHERE document_id = ? ORDER BY file_type',
          variables: <Variable<Object>>[
            Variable<String>(data['id']! as String),
          ],
        )
        .get();
    return ArchiveDocument(
      id: data['id']! as String,
      collectionId: data['collection_id']! as String,
      slug: data['slug']! as String,
      displayTitle: data['display_title']! as String,
      documentType: data['document_type']! as String,
      documentNumber: data['document_number'] as int?,
      parentNumber: data['parent_number'] as int?,
      partNumber: data['part_number'] as int?,
      partLabel: data['part_label'] as String?,
      subtitle: data['subtitle'] as String?,
      author: data['author'] as String?,
      speaker: data['speaker'] as String?,
      publicationDate: data['publication_date'] as String?,
      year: data['year'] as int?,
      month: data['month'] as int?,
      sortOrder: data['sort_order']! as int,
      hasResponsiveText: data['has_responsive_text'] == 1,
      hasCleanPdf: data['has_clean_pdf'] == 1,
      hasOriginalScan: data['has_original_scan'] == 1,
      contentVersion: data['content_version']! as int,
      numberVerified: data['number_verified'] == 1,
      metadata: jsonDecode(data['metadata_json']! as String) as Json,
      assets: assetRows
          .map(
            (row) => DocumentAsset(
              id: row.read<String>('id'),
              fileType: row.read<String>('file_type'),
              version: row.read<int>('version'),
              assetPath: row.readNullable<String>('asset_path'),
              localPath: row.readNullable<String>('local_path'),
              remoteUrl: row.readNullable<String>('remote_url'),
              fileSize: row.readNullable<int>('file_size'),
              sha256: row.readNullable<String>('sha256'),
              durationSeconds: row.readNullable<int>('duration_seconds'),
              metadata: jsonDecode(row.read<String>('metadata_json')) as Json,
              downloadState: row.read<String>('download_state'),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<List<DocumentBlock>> getBlocks(String documentId) async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT * FROM document_blocks WHERE document_id = ? ORDER BY order_index',
          variables: <Variable<Object>>[Variable<String>(documentId)],
        )
        .get();
    return rows
        .map(
          (row) => DocumentBlock(
            id: row.read<String>('id'),
            documentId: row.read<String>('document_id'),
            orderIndex: row.read<int>('order_index'),
            blockType: row.read<String>('block_type'),
            text: row.read<String>('block_text'),
            numberLabel: row.readNullable<String>('number_label'),
            headingLevel: row.readNullable<int>('heading_level'),
            metadata: jsonDecode(row.read<String>('metadata_json')) as Json,
          ),
        )
        .toList();
  }

  @override
  Future<List<BibleBook>> getBibleBooks(String collectionId) async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT book_id, book_name, book_order, testament, MAX(chapter) AS chapter_count '
          'FROM bible_verses WHERE collection_id = ? '
          'GROUP BY book_id, book_name, book_order, testament ORDER BY book_order',
          variables: <Variable<Object>>[Variable<String>(collectionId)],
        )
        .get();
    return rows
        .map(
          (row) => BibleBook(
            id: row.read<String>('book_id'),
            name: row.read<String>('book_name'),
            order: row.read<int>('book_order'),
            testament: row.read<String>('testament'),
            chapterCount: row.read<int>('chapter_count'),
          ),
        )
        .toList();
  }

  @override
  Future<List<BibleVerse>> getBibleVerses(
    String collectionId,
    String bookId,
    int chapter,
  ) async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT * FROM bible_verses WHERE collection_id = ? AND book_id = ? AND chapter = ? ORDER BY verse',
          variables: <Variable<Object>>[
            Variable<String>(collectionId),
            Variable<String>(bookId),
            Variable<int>(chapter),
          ],
        )
        .get();
    return rows.map(_bibleVerseFromRow).toList();
  }

  BibleVerse _bibleVerseFromRow(QueryRow row) => BibleVerse(
    id: row.read<String>('id'),
    collectionId: row.read<String>('collection_id'),
    translationCode: row.read<String>('translation_code'),
    bookId: row.read<String>('book_id'),
    bookName: row.read<String>('book_name'),
    bookOrder: row.read<int>('book_order'),
    chapter: row.read<int>('chapter'),
    verse: row.read<int>('verse'),
    text: row.read<String>('verse_text'),
    documentId: row.read<String>('document_id'),
    blockId: row.read<String>('block_id'),
  );

  @override
  Future<BibleReferenceTarget?> resolveBibleReference(String reference) async {
    final parsed = _scriptureParser
        .parse(reference)
        .spans
        .where((span) => span.isClickable)
        .firstOrNull;
    if (parsed == null || parsed.segments.isEmpty) return null;
    final segment = parsed.segments.first;
    final kjv = await getKjvCollection();
    if (kjv == null) return null;
    final installed = await getInstalledCollectionIds();
    if (!installed.contains(kjv.id)) return null;
    return BibleReferenceTarget(
      collectionId: kjv.id,
      collectionName: kjv.name,
      translationCode: kjv.translationCode ?? 'KJV',
      bookId: segment.bookId,
      bookName: segment.bookName,
      chapter: segment.chapter,
      verse: segment.verseStart,
      verseEnd: segment.verseEnd,
    );
  }

  @override
  Future<List<ScriptureReferenceSpan>> getScriptureReferenceSpans(
    String documentId,
  ) async {
    await _ensureScriptureIndexCurrent();
    final rows = await _databases.archive
        .customSelect(
          'SELECT * FROM scripture_reference_spans WHERE document_id = ? '
          'ORDER BY block_id, start_offset',
          variables: <Variable<Object>>[Variable<String>(documentId)],
        )
        .get();
    final result = <ScriptureReferenceSpan>[];
    for (final row in rows) {
      final id = row.read<String>('id');
      final segmentRows = await _databases.archive
          .customSelect(
            'SELECT * FROM scripture_reference_segments WHERE span_id = ? '
            'ORDER BY segment_order',
            variables: <Variable<Object>>[Variable<String>(id)],
          )
          .get();
      final segments = <ScriptureReferenceSegment>[
        for (final segment in segmentRows)
          ScriptureReferenceSegment(
            bookId: segment.read<String>('book_id'),
            bookName: ScriptureReferenceParser.bookNameFor(
              segment.read<String>('book_id'),
            ),
            chapter: segment.read<int>('chapter'),
            verseStart: segment.readNullable<int>('verse_start'),
            verseEnd: segment.readNullable<int>('verse_end'),
          ),
      ];
      result.add(
        ScriptureReferenceSpan(
          id: id,
          rawText: row.read<String>('raw_text'),
          startOffset: row.read<int>('start_offset'),
          endOffset: row.read<int>('end_offset'),
          confidence: ScriptureReferenceConfidence.values.byName(
            row.read<String>('confidence'),
          ),
          segments: segments,
          parserVersion: row.read<int>('parser_version'),
          overrideVersion: row.readNullable<int>('override_version'),
        ),
      );
    }
    return result;
  }

  @override
  Future<CollectionSummary?> getKjvCollection() async {
    final catalogue = await loadCatalogue();
    for (final collection in catalogue.collections) {
      if (collection.collectionType.toLowerCase() == 'bible' &&
          collection.translationCode?.toUpperCase() == 'KJV') {
        return collection;
      }
    }
    return null;
  }

  @override
  Future<List<BibleVerse>> getBibleVersesForSegments(
    String collectionId,
    List<ScriptureReferenceSegment> segments,
  ) async {
    final result = <BibleVerse>[];
    final seen = <String>{};
    for (final segment in segments) {
      final chapter = await getBibleVerses(
        collectionId,
        segment.bookId,
        segment.chapter,
      );
      for (final verse in chapter) {
        if (segment.verseStart != null &&
            (verse.verse < segment.verseStart! ||
                verse.verse > (segment.verseEnd ?? segment.verseStart!))) {
          continue;
        }
        if (seen.add(verse.id)) result.add(verse);
      }
    }
    return result;
  }

  @override
  Future<List<ScriptureOccurrence>> getScriptureOccurrences({
    required String bookId,
    required int chapter,
    int? verse,
    String? collectionId,
    bool chapterOnly = false,
  }) async {
    await _ensureScriptureIndexCurrent();
    final collectionClause = collectionId == null
        ? ''
        : ' AND s.collection_id = ?';
    final variables = <Variable<Object>>[
      Variable<String>(bookId),
      Variable<int>(chapter),
      if (!chapterOnly && verse != null) Variable<int>(verse),
      if (collectionId != null) Variable<String>(collectionId),
    ];
    final source = chapterOnly
        ? 'scripture_reference_segments x JOIN scripture_reference_spans s ON s.id = x.span_id'
        : 'scripture_verse_occurrences x JOIN scripture_reference_spans s ON s.id = x.span_id';
    final verseClause = chapterOnly
        ? ' AND x.verse_start IS NULL'
        : verse == null
        ? ''
        : ' AND x.verse = ?';
    final rows = await _databases.archive
        .customSelect(
          'SELECT s.*, c.name AS collection_name, d.display_title, '
          'b.block_text, b.number_label '
          'FROM $source '
          'JOIN archive_collections c ON c.id = s.collection_id '
          'JOIN documents d ON d.id = s.document_id '
          'JOIN document_blocks b ON b.id = s.block_id '
          'WHERE x.book_id = ? AND x.chapter = ?$verseClause$collectionClause '
          'ORDER BY c.display_order, d.sort_order, b.order_index, s.start_offset',
          variables: variables,
        )
        .get();
    return <ScriptureOccurrence>[
      for (final row in rows)
        ScriptureOccurrence(
          spanId: row.read<String>('id'),
          collectionId: row.read<String>('collection_id'),
          collectionName: row.read<String>('collection_name'),
          documentId: row.read<String>('document_id'),
          documentTitle: row.read<String>('display_title'),
          blockId: row.read<String>('block_id'),
          blockText: row.read<String>('block_text'),
          rawText: row.read<String>('raw_text'),
          startOffset: row.read<int>('start_offset'),
          endOffset: row.read<int>('end_offset'),
          bookId: bookId,
          chapter: chapter,
          verse: verse,
          blockLabel: row.readNullable<String>('number_label'),
          chapterOnly: chapterOnly,
        ),
    ];
  }

  @override
  Future<void> downloadCollection(String collectionId) async {
    _cancelledCollections.remove(collectionId);
    final collection = (await loadCatalogue()).collections.firstWhere(
      (item) => item.id == collectionId,
    );
    await _setDownloadState(collection, 'downloading', bytes: 0);
    try {
      if (collection.pack != null) {
        final source = await _downloadRemotePack(collection);
        await _installCollectionSource(collection, source);
      } else {
        final source = await _downloadPublishedCollection(collection);
        await _installCollectionSource(collection, source);
      }
      await _setDownloadState(
        collection,
        'downloaded',
        bytes: collection.downloadSize,
        installed: true,
      );
    } on _DownloadCancelled {
      await _setDownloadState(collection, 'not_downloaded', bytes: 0);
    } catch (error) {
      await _setDownloadState(collection, 'error', error: error.toString());
      rethrow;
    }
  }

  Future<void> _setDownloadState(
    CollectionSummary collection,
    String state, {
    int bytes = 0,
    int? totalBytes,
    bool installed = false,
    String? error,
  }) async {
    await _databases.app.customStatement(
      'INSERT OR REPLACE INTO downloaded_collections '
      '(collection_id, content_version, state, downloaded_bytes, total_bytes, error_message, installed_at) '
      'VALUES (?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        collection.id,
        collection.contentVersion,
        state,
        bytes,
        totalBytes ?? collection.downloadSize,
        error,
        installed ? DateTime.now().toUtc().toIso8601String() : null,
      ],
    );
  }

  Future<Json> _downloadPublishedCollection(
    CollectionSummary collection,
  ) async {
    final catalogueUri = Uri.parse(_config.catalogueUrl);
    final manifest = await _loadPublishedManifest(collection);
    final schemaVersion =
        manifest['schemaVersion'] ?? manifest['schema_version'];
    final manifestCollectionId = manifest['id'] ?? manifest['collectionId'];
    if ((schemaVersion is num && schemaVersion.toInt() != 1) ||
        (schemaVersion != null && schemaVersion is! num) ||
        (manifestCollectionId != null &&
            manifestCollectionId != collection.id) ||
        (manifest['documents'] is! List &&
            manifest['contentPattern'] is! String)) {
      throw const FormatException('Published collection manifest is invalid.');
    }
    final documentUris = await _publishedDocumentUris(catalogueUri, manifest);
    if (documentUris.isEmpty) {
      throw StateError(
        'No published documents are available for this collection.',
      );
    }

    final documents = <Json>[];
    var downloadedBytes = 0;
    const batchSize = 8;
    for (var offset = 0; offset < documentUris.length; offset += batchSize) {
      if (_cancelledCollections.contains(collection.id)) {
        throw const _DownloadCancelled();
      }
      final end = (offset + batchSize).clamp(0, documentUris.length);
      final batch = await Future.wait(
        documentUris
            .sublist(offset, end)
            .map((uri) => _downloadPublishedDocument(collection, uri)),
      );
      for (final result in batch) {
        downloadedBytes += result.bytes;
        documents.add(result.document);
      }
      if (downloadedBytes > 128 * 1024 * 1024) {
        throw const FormatException(
          'Published collection exceeds the safe limit.',
        );
      }
      await _setDownloadState(
        collection,
        'downloading',
        bytes: documents.length,
        totalBytes: documentUris.length,
      );
    }
    return <String, Object?>{
      'schemaVersion': 1,
      'documents': documents,
      '_sourceFingerprint': _manifestFingerprint(manifest),
    };
  }

  Future<Json> _loadPublishedManifest(CollectionSummary collection) async {
    final manifestUri = _withRefreshToken(
      Uri.parse(_config.catalogueUrl).resolve(collection.manifestPath!),
    );
    _requireAllowedSource(manifestUri);
    return _getJson(manifestUri);
  }

  String _manifestFingerprint(Json manifest) =>
      sha256.convert(utf8.encode(jsonEncode(manifest))).toString();

  Future<({Json document, int bytes})> _downloadPublishedDocument(
    CollectionSummary collection,
    Uri documentUri,
  ) async {
    _requireAllowedSource(documentUri);
    final response = await _dio.get<String>(
      documentUri.toString(),
      options: Options(
        responseType: ResponseType.plain,
        headers: const <String, Object?>{
          'cache-control': 'no-cache',
          'pragma': 'no-cache',
        },
      ),
    );
    final body = response.data;
    if (body == null || body.length > 4 * 1024 * 1024) {
      throw const FormatException('Published document is empty or too large.');
    }
    final sourceDocument = jsonDecode(body);
    final sourceCollectionId = sourceDocument is Json
        ? sourceDocument['collection'] ?? sourceDocument['collectionId']
        : null;
    if (sourceDocument is! Json ||
        (sourceCollectionId != null && sourceCollectionId != collection.id)) {
      throw const FormatException('Published document metadata is invalid.');
    }
    return (
      document: _convertPublishedDocument(collection, sourceDocument),
      bytes: utf8.encode(body).length,
    );
  }

  Future<List<Uri>> _publishedDocumentUris(
    Uri catalogueUri,
    Json manifest,
  ) async {
    final declaredDocuments = manifest['documents'];
    if (declaredDocuments is List<Object?>) {
      final collectionId = manifest['id'] ?? manifest['collectionId'];
      if ((collectionId != null && collectionId is! String) ||
          declaredDocuments.isEmpty) {
        throw const FormatException('Manifest document list is invalid.');
      }
      final urls = <Uri>[];
      final manifestIds = <String>{};
      for (final entry in declaredDocuments) {
        if (entry is String) {
          urls.add(_withRefreshToken(catalogueUri.resolve(entry)));
          continue;
        }
        if (entry is! Json) {
          throw const FormatException('Manifest document entry is invalid.');
        }
        final id = entry['id'];
        final assets = entry['assets'];
        final jsonAsset = assets is Json ? assets['json'] : null;
        final fileName =
            entry['json'] ?? (jsonAsset is Json ? jsonAsset['file'] : null);
        if (id is! String ||
            !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id) ||
            !manifestIds.add(id) ||
            fileName is! String ||
            !fileName.endsWith('.json') ||
            fileName.contains('\\') ||
            p.posix.basename(fileName) != fileName) {
          throw const FormatException('Manifest document entry is invalid.');
        }
        urls.add(
          _withRefreshToken(
            catalogueUri.resolve('content/$collectionId/$fileName'),
          ),
        );
      }
      return urls;
    }

    final pattern = manifest['contentPattern'];
    if (pattern is! String || pattern.isEmpty) {
      throw const FormatException(
        'Manifest must declare contentPattern or documents.',
      );
    }
    if (catalogueUri.host != 'raw.githubusercontent.com' ||
        catalogueUri.pathSegments.length < 4) {
      throw const FormatException(
        'This catalogue host must list document URLs in its manifest.',
      );
    }
    final owner = catalogueUri.pathSegments[0];
    final repository = catalogueUri.pathSegments[1];
    final revision = catalogueUri.pathSegments[2];
    final directory = p.posix.dirname(pattern);
    if (directory == '.' || directory.startsWith('../')) {
      throw const FormatException('Manifest contentPattern is unsafe.');
    }
    final apiUri = Uri.https(
      'api.github.com',
      '/repos/$owner/$repository/contents/$directory',
      <String, String>{'ref': revision},
    );
    final response = await _dio.get<List<Object?>>(
      apiUri.toString(),
      options: Options(
        headers: const <String, Object?>{
          'accept': 'application/vnd.github+json',
          'x-github-api-version': '2022-11-28',
        },
      ),
    );
    final entries = response.data ?? const <Object?>[];
    final urls = <Uri>[];
    for (final entry in entries) {
      if (entry is! Map) continue;
      final name = entry['name'];
      final downloadUrl = entry['download_url'];
      if (name is String && name.endsWith('.json') && downloadUrl is String) {
        urls.add(Uri.parse(downloadUrl));
      }
    }
    urls.sort((a, b) => a.path.compareTo(b.path));
    return urls;
  }

  Uri _withRefreshToken(Uri uri) => uri.replace(
    queryParameters: <String, String>{
      ...uri.queryParameters,
      'archive_refresh': DateTime.now()
          .toUtc()
          .millisecondsSinceEpoch
          .toString(),
    },
  );

  Future<Json> _getJson(Uri uri) async {
    _requireAllowedSource(uri);
    final response = await _dio.get<String>(
      uri.toString(),
      options: Options(
        responseType: ResponseType.plain,
        headers: const <String, Object?>{
          'cache-control': 'no-cache',
          'pragma': 'no-cache',
        },
      ),
    );
    final body = response.data;
    if (body == null || body.length > 1024 * 1024) {
      throw const FormatException('Remote JSON is empty or too large.');
    }
    final decoded = jsonDecode(body);
    if (decoded is! Json) {
      throw const FormatException('Expected a JSON object.');
    }
    return decoded;
  }

  void _requireAllowedSource(Uri uri) {
    final localDevelopment =
        _config.isDevelopment &&
        (uri.host == 'localhost' || uri.host == '127.0.0.1');
    if (uri.scheme != 'https' && !(localDevelopment && uri.scheme == 'http')) {
      throw const FormatException('Archive sources must use HTTPS.');
    }
  }

  Json _convertPublishedDocument(CollectionSummary collection, Json source) {
    final id = source['id'];
    if (id is! String || !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id)) {
      throw const FormatException('Published document has an invalid id.');
    }
    final number = ((source['scroll_number'] ?? source['number']) as num?)
        ?.toInt();
    final part = (source['part'] as num?)?.toInt();
    final year = (source['year'] as num?)?.toInt();
    final month = (source['month'] as num?)?.toInt();
    final title = _publishedTitle(collection.id, source, number, part);
    final publicationDate = _publishedDate(source, year, month);
    final rawVerses = source['verses'];
    final rawBlocks = source['blocks'] is List<Object?>
        ? source['blocks']! as List<Object?>
        : rawVerses is List<Object?>
        ? rawVerses
        : const <Object?>[];
    if (rawBlocks.isEmpty &&
        !collection.capabilities.audio &&
        source['assets'] is! List<Object?>) {
      throw FormatException('$id does not contain readable blocks or assets.');
    }
    final blocks = <Json>[];
    final blockIds = <String>{};
    for (var index = 0; index < rawBlocks.length; index++) {
      final raw = rawBlocks[index];
      if (raw is! Json || raw['text'] is! String) {
        throw FormatException('$id contains an invalid block.');
      }
      final verseNumber = (raw['verse'] as num?)?.toInt();
      final sourceBlockId =
          raw['id'] as String? ??
          (verseNumber == null
              ? null
              : 'verse-${verseNumber.toString().padLeft(3, '0')}');
      if (sourceBlockId == null || sourceBlockId.isEmpty) {
        throw FormatException('$id contains an invalid block id.');
      }
      final blockId = sourceBlockId.startsWith('$id:')
          ? sourceBlockId
          : '$id:$sourceBlockId';
      if (!blockIds.add(blockId)) {
        throw FormatException('$id contains duplicate block ids.');
      }
      blocks.add(<String, Object?>{
        'id': blockId,
        'type':
            raw['type'] as String? ??
            (verseNumber == null ? 'paragraph' : 'numbered_item'),
        'orderIndex': index + 1,
        'text': raw['text'],
        'numberLabel':
            raw['numberLabel']?.toString() ?? verseNumber?.toString(),
        'headingLevel': (raw['headingLevel'] as num?)?.toInt(),
        'metadata': <String, Object?>{
          if (raw['metadata'] is Json) ...(raw['metadata']! as Json),
          'verse': verseNumber,
          if (raw['verseId'] != null) 'verseId': raw['verseId'],
        },
      });
    }
    final documentType =
        (source['documentType'] ?? source['document_type']) as String? ??
        switch (collection.id) {
          'special-writings' => 'special_writing',
          'translation-alerts' => 'translation_alert',
          'monthly-letters' => 'monthly_letter',
          _ => 'document',
        };
    final declaredSortOrder =
        ((source['sortOrder'] ?? source['sort_order']) as num?)?.toInt();
    final sortOrder =
        declaredSortOrder ??
        switch (collection.collectionType) {
          'monthly_letters' when year != null && month != null =>
            year * 12 + month,
          _ => (number ?? 0) * 10 + (part ?? 0),
        };
    final assets = <Json>[];
    final rawAssets = source['assets'];
    if (rawAssets is List<Object?>) {
      for (var index = 0; index < rawAssets.length; index++) {
        final raw = rawAssets[index];
        if (raw is! Json) {
          throw FormatException('$id contains an invalid asset.');
        }
        final fileType = raw['fileType'] ?? raw['type'];
        final assetId = raw['id'] ?? '$id:${fileType ?? 'asset'}-${index + 1}';
        if (fileType is! String || assetId is! String) {
          throw FormatException('$id contains an invalid asset descriptor.');
        }
        assets.add(<String, Object?>{
          'id': assetId,
          'fileType': fileType,
          'remoteUrl': raw['remoteUrl'] ?? raw['url'],
          'assetPath': raw['assetPath'],
          'fileSize': raw['fileSize'] ?? raw['size_bytes'],
          'sha256': raw['sha256'],
          'durationSeconds': raw['durationSeconds'] ?? raw['duration_seconds'],
          'version':
              (raw['version'] as num?)?.toInt() ?? collection.contentVersion,
          'metadata': Map<String, Object?>.from(raw),
        });
      }
    }
    final metadata = Map<String, Object?>.from(source)
      ..remove('blocks')
      ..remove('verses')
      ..remove('assets')
      ..remove('files');
    final hasCleanPdf = assets.any(
      (asset) => asset['fileType'] == 'clean_pdf' || asset['fileType'] == 'pdf',
    );
    final hasOriginalScan = assets.any(
      (asset) => asset['fileType'] == 'original_scan',
    );
    return <String, Object?>{
      'id': id,
      'collectionId': collection.id,
      'slug': id,
      'displayTitle': title,
      'documentType': documentType,
      'documentNumber': number,
      'parentNumber': part == null ? null : number,
      'partNumber': part,
      'partLabel': part == null ? null : 'Part $part',
      'subtitle': source['date_raw'] as String?,
      'author': source['author'] as String?,
      'speaker': source['speaker'] as String?,
      'publicationDate': publicationDate,
      'year': year,
      'month': month,
      'sortOrder': sortOrder,
      'hasResponsiveText': blocks.isNotEmpty,
      'hasCleanPdf': hasCleanPdf,
      'hasOriginalScan': hasOriginalScan,
      'contentVersion': collection.contentVersion,
      'numberVerified': source['number_verified_from_page_code'] != false,
      'blocks': blocks,
      'metadata': metadata,
      'assets': assets,
    };
  }

  String _publishedTitle(
    String collectionId,
    Json source,
    int? number,
    int? part,
  ) {
    if (collectionId == 'prophetic-scrolls' && number != null) {
      return 'Scroll $number${part == null ? '' : ' — Part $part'}';
    }
    final title =
        source['title'] as String? ??
        source['displayTitle'] as String? ??
        source['display_title'] as String? ??
        '';
    if ((collectionId == 'special-writings' ||
            collectionId == 'translation-alerts') &&
        number != null) {
      return '${number.toString().padLeft(3, '0')} — $title';
    }
    if (title.isEmpty) {
      throw const FormatException('Document title is missing.');
    }
    return title;
  }

  String? _publishedDate(Json source, int? year, int? month) {
    if (year != null && month != null && month >= 1 && month <= 12) {
      return '$year-${month.toString().padLeft(2, '0')}-01';
    }
    final raw = source['date_raw'];
    if (raw is! String) return null;
    const months = <String, int>{
      'january': 1,
      'february': 2,
      'march': 3,
      'april': 4,
      'may': 5,
      'june': 6,
      'july': 7,
      'august': 8,
      'september': 9,
      'october': 10,
      'november': 11,
      'december': 12,
    };
    final match = RegExp(
      r'^(\w+)\s+(\d{1,2}),\s+(\d{4})',
      caseSensitive: false,
    ).firstMatch(raw.trim());
    if (match == null) return null;
    final parsedMonth = months[match.group(1)!.toLowerCase()];
    if (parsedMonth == null) return null;
    return '${match.group(3)}-${parsedMonth.toString().padLeft(2, '0')}-'
        '${int.parse(match.group(2)!).toString().padLeft(2, '0')}';
  }

  Future<Json> _downloadRemotePack(CollectionSummary collection) async {
    final pack = collection.pack!;
    final packUrl = Uri.parse(
      _config.catalogueUrl,
    ).resolve(pack.url).toString();
    if (!packUrl.startsWith('https://')) {
      throw const FormatException('Remote content packs must use HTTPS.');
    }
    final support = await getApplicationSupportDirectory();
    await _requireFreeSpace(support.path, pack.fileSize);
    final temporary = Directory(p.join(support.path, 'downloads'))
      ..createSync(recursive: true);
    final partFile = File(p.join(temporary.path, '${collection.id}.tpa.part'));
    var received = partFile.existsSync() ? partFile.lengthSync() : 0;
    final response = await _dio.get<ResponseBody>(
      packUrl,
      options: Options(
        responseType: ResponseType.stream,
        headers: received > 0
            ? <String, Object?>{'range': 'bytes=$received-'}
            : null,
      ),
    );
    if (received > 0 && response.statusCode != HttpStatus.partialContent) {
      received = 0;
    }
    final sink = partFile.openWrite(
      mode: received > 0 ? FileMode.append : FileMode.write,
    );
    try {
      await for (final bytes in response.data!.stream) {
        if (_cancelledCollections.contains(collection.id)) {
          throw const _DownloadCancelled();
        }
        sink.add(bytes);
        received += bytes.length;
        if (received > pack.fileSize) {
          throw const FormatException(
            'Downloaded pack exceeds its declared size.',
          );
        }
        await _setDownloadState(collection, 'downloading', bytes: received);
      }
    } finally {
      await sink.close();
    }
    if (partFile.lengthSync() != pack.fileSize) {
      throw const FormatException(
        'Downloaded pack size does not match the catalogue.',
      );
    }
    final digest = await sha256.bind(partFile.openRead()).first;
    if (digest.toString().toLowerCase() != pack.sha256.toLowerCase()) {
      throw const FormatException(
        'Downloaded pack checksum does not match the catalogue.',
      );
    }
    final archive = ZipDecoder().decodeBytes(
      partFile.readAsBytesSync(),
      verify: true,
    );
    final maximumExpanded = pack.fileSize * 8 + 64 * 1024 * 1024;
    var expanded = 0;
    ArchiveFile? contentFile;
    ArchiveFile? databaseFile;
    for (final file in archive.files) {
      final normalized = p.posix.normalize(file.name.replaceAll('\\', '/'));
      if (p.posix.isAbsolute(normalized) ||
          normalized == '..' ||
          normalized.startsWith('../')) {
        throw const FormatException('Content pack contains an unsafe path.');
      }
      expanded += file.size;
      if (expanded > maximumExpanded) {
        throw const FormatException(
          'Content pack expands beyond the allowed size.',
        );
      }
      if (normalized == 'content.json') contentFile = file;
      if (normalized == 'content.sqlite') databaseFile = file;
    }
    if (contentFile == null || databaseFile == null) {
      throw const FormatException(
        'Content pack is missing content.json or content.sqlite.',
      );
    }
    await _validatePackedDatabase(databaseFile, temporary, collection);
    final decoded = jsonDecode(utf8.decode(contentFile.readBytes()!)) as Json;
    if (decoded['schemaVersion'] != 1 ||
        decoded['developmentFixture'] == true) {
      throw const FormatException(
        'Remote content pack has an unsupported or development schema.',
      );
    }
    return decoded;
  }

  Future<void> _validatePackedDatabase(
    ArchiveFile archiveFile,
    Directory temporary,
    CollectionSummary collection,
  ) async {
    final inspectionFile = File(
      p.join(temporary.path, '${collection.id}.inspection.sqlite'),
    );
    await inspectionFile.writeAsBytes(archiveFile.readBytes()!, flush: true);
    sqlite.Database? database;
    try {
      database = sqlite.sqlite3.open(inspectionFile.path);
      final check = database.select('PRAGMA quick_check').first.values.first;
      if (check != 'ok') {
        throw const FormatException('Packed SQLite integrity check failed.');
      }
      final metadata = database.select(
        'SELECT schema_version, collection_id, content_version, development_fixture '
        'FROM pack_metadata LIMIT 1',
      );
      if (metadata.length != 1 ||
          metadata.first['schema_version'] != 1 ||
          metadata.first['collection_id'] != collection.id ||
          metadata.first['content_version'] != collection.contentVersion ||
          metadata.first['development_fixture'] != 0) {
        throw const FormatException('Packed SQLite metadata is invalid.');
      }
      final tables = database
          .select(
            "SELECT name FROM sqlite_master WHERE type IN ('table', 'view')",
          )
          .map((row) => row['name'])
          .whereType<String>()
          .toSet();
      const required = <String>{
        'pack_metadata',
        'documents',
        'document_blocks',
        'search_index',
      };
      if (!tables.containsAll(required)) {
        throw const FormatException('Packed SQLite schema is incomplete.');
      }
    } on sqlite.SqliteException catch (error) {
      throw FormatException('Packed SQLite could not be inspected: $error');
    } finally {
      database?.close();
      if (inspectionFile.existsSync()) await inspectionFile.delete();
    }
  }

  Future<void> _requireFreeSpace(String path, int downloadBytes) async {
    final free = await _diskSpace.getFreeBytes(path);
    if (free == null) return;
    const reserve = 64 * 1024 * 1024;
    final required = downloadBytes * 2 + reserve;
    if (free < required) {
      throw StateError(
        'Not enough free space. ${_formatStorageBytes(required)} is required.',
      );
    }
  }

  Future<void> _installCollectionSource(
    CollectionSummary collection,
    Json source,
  ) async {
    if (source['schemaVersion'] != 1 || source['developmentFixture'] == true) {
      throw const FormatException('Invalid content pack');
    }
    final documents = (source['documents']! as List<Object?>)
        .cast<Json>()
        .where((document) => document['collectionId'] == collection.id)
        .toList();
    final ids = documents.map((item) => item['id']).toSet();
    if (ids.length != documents.length) {
      throw const FormatException('Duplicate document id');
    }

    await _databases.archive.transaction(() async {
      await _databases.archive.customStatement(
        'DELETE FROM search_index WHERE collection_id = ?',
        <Object?>[collection.id],
      );
      await _databases.archive.customStatement(
        'DELETE FROM archive_collections WHERE id = ?',
        <Object?>[collection.id],
      );
      await _databases.archive.customStatement(
        'INSERT INTO archive_collections '
        '(id, slug, name, description, collection_type, display_order, document_count, unique_item_count, content_version, metadata_json) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        <Object?>[
          collection.id,
          collection.slug,
          collection.name,
          collection.description,
          collection.collectionType,
          collection.displayOrder,
          collection.documentCount,
          collection.uniqueItemCount,
          collection.contentVersion,
          jsonEncode(collection.metadata),
        ],
      );
      for (final document in documents) {
        await _insertArchiveDocument(collection, document);
      }
      for (final document in documents) {
        await _insertCrossReferences(document);
      }
    });
    await _reanchorStudyRecords(documents);
    await setValue(
      'scripture_parser_version',
      scriptureParserVersion.toString(),
    );
    final fingerprint = source['_sourceFingerprint']?.toString();
    if (fingerprint != null) {
      await setValue('collection_fingerprint:${collection.id}', fingerprint);
    }
  }

  Future<void> _reanchorStudyRecords(List<Json> documents) async {
    final replacementText = <String, String>{
      for (final document in documents)
        for (final block in (document['blocks']! as List<Object?>).cast<Json>())
          block['id']! as String: block['text']! as String,
    };
    if (replacementText.isEmpty) return;
    final placeholders = List<String>.filled(
      replacementText.length,
      '?',
    ).join(',');
    final highlights = await _databases.app
        .customSelect(
          'SELECT id, block_id, start_offset, end_offset, selected_text '
          'FROM highlights WHERE block_id IN ($placeholders)',
          variables: <Variable<Object>>[
            for (final id in replacementText.keys) Variable<String>(id),
          ],
        )
        .get();
    for (final highlight in highlights) {
      final text = replacementText[highlight.read<String>('block_id')]!;
      final selected = highlight.read<String>('selected_text');
      final start = highlight.read<int>('start_offset');
      final end = highlight.read<int>('end_offset');
      final anchored =
          start >= 0 &&
          end >= start &&
          end <= text.length &&
          text.substring(start, end) == selected;
      if (anchored) continue;
      final replacementStart = text.indexOf(selected);
      if (replacementStart < 0) continue;
      await _databases.app.customStatement(
        'UPDATE highlights SET start_offset = ?, end_offset = ?, updated_at = ? WHERE id = ?',
        <Object?>[
          replacementStart,
          replacementStart + selected.length,
          DateTime.now().toUtc().toIso8601String(),
          highlight.read<String>('id'),
        ],
      );
    }
  }

  Future<void> _ensureScriptureIndexCurrent() {
    return _scriptureIndexReady ??= _rebuildScriptureIndexIfNeeded();
  }

  Future<void> _rebuildScriptureIndexIfNeeded() async {
    final stored = int.tryParse(
      await getValue('scripture_parser_version') ?? '',
    );
    if (stored == scriptureParserVersion) return;
    await _databases.archive.transaction(() async {
      await _databases.archive.customStatement(
        'DELETE FROM scripture_reference_spans',
      );
      final rows = await _databases.archive
          .customSelect(
            'SELECT c.id AS collection_id, d.id AS document_id, '
            'b.id, b.order_index, b.block_type, b.block_text, b.number_label, '
            'b.heading_level, b.metadata_json '
            'FROM archive_collections c '
            'JOIN documents d ON d.collection_id = c.id '
            'JOIN document_blocks b ON b.document_id = d.id '
            "WHERE lower(c.collection_type) <> 'bible' "
            'ORDER BY c.display_order, d.sort_order, b.order_index',
          )
          .get();
      String? documentId;
      String? collectionId;
      final blocks = <Json>[];
      Future<void> flush() async {
        if (documentId == null || collectionId == null || blocks.isEmpty) {
          return;
        }
        await _indexScriptureBlocks(collectionId, documentId, blocks);
        blocks.clear();
      }

      for (final row in rows) {
        final nextDocument = row.read<String>('document_id');
        if (documentId != null && nextDocument != documentId) await flush();
        documentId = nextDocument;
        collectionId = row.read<String>('collection_id');
        blocks.add(<String, Object?>{
          'id': row.read<String>('id'),
          'orderIndex': row.read<int>('order_index'),
          'type': row.read<String>('block_type'),
          'text': row.read<String>('block_text'),
          'numberLabel': row.readNullable<String>('number_label'),
          'headingLevel': row.readNullable<int>('heading_level'),
          'metadata': jsonDecode(row.read<String>('metadata_json')),
        });
      }
      await flush();
    });
    await setValue(
      'scripture_parser_version',
      scriptureParserVersion.toString(),
    );
  }

  Future<void> _indexScriptureBlocks(
    String collectionId,
    String documentId,
    List<Json> blocks,
  ) async {
    ScriptureParsingContext? context;
    var contextAge = 0;
    for (final block in blocks) {
      final type = block['type']! as String;
      if (type == 'heading' || type == 'divider') {
        context = null;
        contextAge = 0;
      }
      final blockId = block['id']! as String;
      final result = _scriptureParser.parse(
        block['text']! as String,
        documentId: documentId,
        blockId: blockId,
        context: contextAge <= 3 ? context : null,
      );
      for (final span in result.spans) {
        await _persistScriptureSpan(
          collectionId: collectionId,
          documentId: documentId,
          blockId: blockId,
          span: span,
        );
      }
      if (result.trailingContext != null &&
          result.spans.any((span) => span.isClickable)) {
        context = result.trailingContext;
        contextAge = 0;
      } else if ((block['text']! as String).trim().isNotEmpty) {
        contextAge++;
      }
    }
  }

  Future<void> _persistScriptureSpan({
    required String collectionId,
    required String documentId,
    required String blockId,
    required ScriptureReferenceSpan span,
  }) async {
    await _databases.archive.customStatement(
      'INSERT INTO scripture_reference_spans '
      '(id, collection_id, document_id, block_id, start_offset, end_offset, '
      'raw_text, canonical_reference, confidence, parser_version, override_version) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        span.id,
        collectionId,
        documentId,
        blockId,
        span.startOffset,
        span.endOffset,
        span.rawText,
        span.canonicalReference,
        span.confidence.name,
        span.parserVersion,
        span.overrideVersion,
      ],
    );
    for (var index = 0; index < span.segments.length; index++) {
      final segment = span.segments[index];
      await _databases.archive.customStatement(
        'INSERT INTO scripture_reference_segments '
        '(span_id, book_id, chapter, verse_start, verse_end, segment_order) '
        'VALUES (?, ?, ?, ?, ?, ?)',
        <Object?>[
          span.id,
          segment.bookId,
          segment.chapter,
          segment.verseStart,
          segment.verseEnd,
          index,
        ],
      );
      for (final verse in segment.verses) {
        await _databases.archive.customStatement(
          'INSERT OR IGNORE INTO scripture_verse_occurrences '
          '(span_id, collection_id, document_id, block_id, book_id, chapter, verse) '
          'VALUES (?, ?, ?, ?, ?, ?, ?)',
          <Object?>[
            span.id,
            collectionId,
            documentId,
            blockId,
            segment.bookId,
            segment.chapter,
            verse,
          ],
        );
      }
    }
  }

  Future<void> _insertCrossReferences(Json document) async {
    final documentId = document['id']! as String;
    for (final reference
        in ((document['crossReferences'] as List<Object?>?) ??
                const <Object?>[])
            .cast<Json>()) {
      if (reference['verified'] != true) continue;
      await _databases.archive.customStatement(
        'INSERT INTO cross_references '
        '(id, source_document_id, source_block_id, target_document_id, relationship_type, display_text, verified) '
        'VALUES (?, ?, ?, ?, ?, ?, 1)',
        <Object?>[
          reference['id'],
          documentId,
          reference['sourceBlockId'],
          reference['targetDocumentId'],
          reference['relationshipType'],
          reference['displayText'],
        ],
      );
    }
  }

  Future<void> _insertArchiveDocument(
    CollectionSummary collection,
    Json document,
  ) async {
    final documentId = document['id']! as String;
    if (!RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(documentId)) {
      throw FormatException('Unsafe document id: $documentId');
    }
    final blocks = (document['blocks']! as List<Object?>).cast<Json>();
    for (var index = 0; index < blocks.length; index++) {
      if ((blocks[index]['orderIndex']! as num).toInt() != index + 1) {
        throw FormatException('Non-contiguous block order in $documentId');
      }
    }
    await _databases.archive.customStatement(
      'INSERT INTO documents '
      '(id, collection_id, slug, display_title, document_type, document_number, parent_number, part_number, part_label, '
      'subtitle, author, speaker, publication_date, year, month, sort_order, has_responsive_text, has_clean_pdf, '
      'has_original_scan, content_version, number_verified, metadata_json) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        documentId,
        document['collectionId'],
        document['slug'],
        document['displayTitle'],
        document['documentType'],
        document['documentNumber'],
        document['parentNumber'],
        document['partNumber'],
        document['partLabel'],
        document['subtitle'],
        document['author'],
        document['speaker'],
        document['publicationDate'],
        document['year'],
        document['month'],
        document['sortOrder'],
        document['hasResponsiveText'] == true ? 1 : 0,
        document['hasCleanPdf'] == true ? 1 : 0,
        document['hasOriginalScan'] == true ? 1 : 0,
        document['contentVersion'],
        document['numberVerified'] == true ? 1 : 0,
        jsonEncode(document['metadata'] ?? const <String, Object?>{}),
      ],
    );
    for (final block in blocks) {
      final blockId = block['id']! as String;
      if (!blockId.startsWith('$documentId:')) {
        throw FormatException('Block $blockId is not stable under $documentId');
      }
      await _databases.archive.customStatement(
        'INSERT INTO document_blocks '
        '(id, document_id, order_index, block_type, block_text, number_label, heading_level, metadata_json) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        <Object?>[
          blockId,
          documentId,
          block['orderIndex'],
          block['type'],
          block['text'],
          block['numberLabel'],
          block['headingLevel'],
          jsonEncode(block['metadata'] ?? const <String, Object?>{}),
        ],
      );
      final label = block['numberLabel'] == null
          ? ''
          : 'Point ${block['numberLabel']}';
      await _databases.archive.customStatement(
        'INSERT INTO search_index '
        '(collection_id, collection_name, document_id, document_title, block_id, block_label, body) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        <Object?>[
          collection.id,
          collection.name,
          documentId,
          document['displayTitle'],
          blockId,
          label,
          block['text'],
        ],
      );
    }
    if (collection.collectionType.toLowerCase() != 'bible') {
      await _indexScriptureBlocks(collection.id, documentId, blocks);
    }
    for (final asset
        in ((document['assets'] as List<Object?>?) ?? const <Object?>[])
            .cast<Json>()) {
      final previous = await _databases.app
          .customSelect(
            'SELECT local_path FROM downloaded_assets WHERE asset_id = ? AND version = ?',
            variables: <Variable<Object>>[
              Variable<String>(asset['id']! as String),
              Variable<int>((asset['version']! as num).toInt()),
            ],
          )
          .getSingleOrNull();
      final localPath = previous?.read<String>('local_path');
      await _databases.archive.customStatement(
        'INSERT INTO document_files '
        '(id, document_id, file_type, remote_url, asset_path, local_path, file_size, sha256, version, duration_seconds, metadata_json, download_state) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        <Object?>[
          asset['id'],
          documentId,
          asset['fileType'],
          asset['remoteUrl'],
          asset['assetPath'],
          localPath,
          asset['fileSize'],
          asset['sha256'],
          asset['version'],
          asset['durationSeconds'],
          jsonEncode(asset['metadata'] ?? const <String, Object?>{}),
          localPath == null ? 'not_downloaded' : 'downloaded',
        ],
      );
    }
    if (collection.capabilities.bibleReader) {
      await _insertBibleVerses(collection, document, blocks);
    }
    for (final topicName
        in ((document['topics'] as List<Object?>?) ?? const <Object?>[])
            .cast<String>()) {
      final topicId = topicName.toLowerCase().replaceAll(
        RegExp('[^a-z0-9]+'),
        '-',
      );
      await _databases.archive.customStatement(
        'INSERT OR IGNORE INTO topics (id, name) VALUES (?, ?)',
        <Object?>[topicId, topicName],
      );
      await _databases.archive.customStatement(
        'INSERT OR IGNORE INTO document_topics (document_id, topic_id) VALUES (?, ?)',
        <Object?>[documentId, topicId],
      );
    }
    for (final reference
        in ((document['scriptureReferences'] as List<Object?>?) ??
                const <Object?>[])
            .cast<Json>()) {
      await _databases.archive.customStatement(
        'INSERT INTO scripture_references '
        '(document_id, block_id, book, chapter, verse_start, verse_end, canonical_reference) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        <Object?>[
          documentId,
          reference['blockId'],
          reference['book'],
          reference['chapter'],
          reference['verseStart'],
          reference['verseEnd'],
          reference['canonicalReference'],
        ],
      );
    }
    final publicationDate = document['publicationDate'] as String?;
    if (publicationDate != null) {
      await _databases.archive.customStatement(
        'INSERT INTO timeline_entries '
        '(id, document_id, date, date_type, display_label) VALUES (?, ?, ?, ?, ?)',
        <Object?>[
          '$documentId:publication-date',
          documentId,
          publicationDate,
          'publication',
          document['displayTitle'],
        ],
      );
    }
  }

  Future<void> _insertBibleVerses(
    CollectionSummary collection,
    Json document,
    List<Json> blocks,
  ) async {
    final metadata =
        (document['metadata'] as Json?) ?? const <String, Object?>{};
    final translation =
        metadata['translationCode']?.toString() ??
        metadata['translation_code']?.toString() ??
        collection.translationCode ??
        collection.name;
    final bookId =
        metadata['bookId']?.toString() ?? metadata['book_id']?.toString();
    final bookName =
        metadata['bookName']?.toString() ?? metadata['book']?.toString();
    final bookOrder =
        ((metadata['bookOrder'] ?? metadata['book_order']) as num?)?.toInt();
    final chapter = (metadata['chapter'] as num?)?.toInt();
    if (bookId == null ||
        bookName == null ||
        bookOrder == null ||
        chapter == null ||
        bookOrder < 1 ||
        chapter < 1) {
      throw FormatException(
        '${document['id']} is missing Bible book or chapter metadata.',
      );
    }
    for (final block in blocks) {
      final blockMetadata =
          (block['metadata'] as Json?) ?? const <String, Object?>{};
      final verse =
          (blockMetadata['verse'] as num?)?.toInt() ??
          int.tryParse(block['numberLabel']?.toString() ?? '');
      if (verse == null || verse < 1) {
        throw FormatException('${block['id']} has no valid verse number.');
      }
      final verseId =
          blockMetadata['verseId']?.toString() ??
          '${translation.toLowerCase()}:$bookId:$chapter:$verse';
      await _databases.archive.customStatement(
        'INSERT INTO bible_verses '
        '(id, collection_id, translation_code, book_id, book_name, book_order, testament, chapter, verse, verse_text, document_id, block_id) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        <Object?>[
          verseId,
          collection.id,
          translation,
          bookId,
          bookName,
          bookOrder,
          metadata['testament']?.toString() ?? 'unknown',
          chapter,
          verse,
          block['text'],
          document['id'],
          block['id'],
        ],
      );
    }
  }

  @override
  Future<void> removeCollection(String collectionId) async {
    final downloadedAssets = await _databases.archive
        .customSelect(
          'SELECT document_files.id FROM document_files '
          'JOIN documents ON documents.id = document_files.document_id '
          'WHERE documents.collection_id = ? AND document_files.local_path IS NOT NULL',
          variables: <Variable<Object>>[Variable<String>(collectionId)],
        )
        .get();
    for (final asset in downloadedAssets) {
      await removeAsset(asset.read<String>('id'));
    }
    await _databases.archive.transaction(() async {
      await _databases.archive.customStatement(
        'DELETE FROM search_index WHERE collection_id = ?',
        <Object?>[collectionId],
      );
      await _databases.archive.customStatement(
        'DELETE FROM archive_collections WHERE id = ?',
        <Object?>[collectionId],
      );
    });
    await _databases.app.customStatement(
      'DELETE FROM downloaded_collections WHERE collection_id = ?',
      <Object?>[collectionId],
    );
  }

  @override
  Future<void> cancel(String collectionId) async =>
      _cancelledCollections.add(collectionId);

  @override
  Future<void> retry(String collectionId) => downloadCollection(collectionId);

  @override
  Future<void> downloadAsset(String documentId, DocumentAsset asset) async {
    if (asset.assetPath != null || asset.localPath != null) return;
    final size = asset.fileSize;
    final expectedHash = asset.sha256;
    final remoteUrl = asset.remoteUrl;
    if (size == null ||
        size < 1 ||
        expectedHash == null ||
        !RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(expectedHash) ||
        remoteUrl == null) {
      throw const FormatException('Asset descriptor is incomplete.');
    }
    final url = Uri.parse(_config.catalogueUrl).resolve(remoteUrl).toString();
    if (!url.startsWith('https://')) {
      throw const FormatException('Remote document assets must use HTTPS.');
    }
    final support = await getApplicationSupportDirectory();
    await _requireFreeSpace(support.path, size);
    final directory = Directory(p.join(support.path, 'assets', documentId));
    await directory.create(recursive: true);
    final extension = p.extension(Uri.parse(url).path).toLowerCase();
    const supportedExtensions = <String>{
      '.pdf',
      '.mp3',
      '.m4a',
      '.aac',
      '.wav',
      '.ogg',
      '.flac',
      '.opus',
      '.jpg',
      '.jpeg',
      '.png',
      '.webp',
    };
    final safeExtension = supportedExtensions.contains(extension)
        ? extension
        : '.asset';
    final destination = File(
      p.join(directory.path, '${asset.id}-v${asset.version}$safeExtension'),
    );
    final partial = File('${destination.path}.part');
    var received = partial.existsSync() ? partial.lengthSync() : 0;
    final response = await _dio.get<ResponseBody>(
      url,
      options: Options(
        responseType: ResponseType.stream,
        headers: received == 0
            ? null
            : <String, Object?>{'range': 'bytes=$received-'},
      ),
    );
    if (received > 0 && response.statusCode != HttpStatus.partialContent) {
      received = 0;
    }
    final sink = partial.openWrite(
      mode: received == 0 ? FileMode.write : FileMode.append,
    );
    try {
      await for (final bytes in response.data!.stream) {
        sink.add(bytes);
        received += bytes.length;
        if (received > size) {
          throw const FormatException('Asset exceeds its declared size.');
        }
      }
    } finally {
      await sink.close();
    }
    if (received != size) {
      throw const FormatException('Asset size does not match its descriptor.');
    }
    final digest = await sha256.bind(partial.openRead()).first;
    if (digest.toString().toLowerCase() != expectedHash.toLowerCase()) {
      throw const FormatException('Asset checksum does not match.');
    }
    if (destination.existsSync()) await destination.delete();
    await partial.rename(destination.path);
    final now = DateTime.now().toUtc().toIso8601String();
    await _databases.app.customStatement(
      'INSERT OR REPLACE INTO downloaded_assets '
      '(asset_id, document_id, file_type, local_path, file_size, sha256, version, installed_at) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        asset.id,
        documentId,
        asset.fileType,
        destination.path,
        size,
        expectedHash,
        asset.version,
        now,
      ],
    );
    await _databases.archive.customStatement(
      "UPDATE document_files SET local_path = ?, download_state = 'downloaded' WHERE id = ?",
      <Object?>[destination.path, asset.id],
    );
  }

  @override
  Future<void> removeAsset(String assetId) async {
    final row = await _databases.app
        .customSelect(
          'SELECT local_path FROM downloaded_assets WHERE asset_id = ?',
          variables: <Variable<Object>>[Variable<String>(assetId)],
        )
        .getSingleOrNull();
    final localPath = row?.read<String>('local_path');
    if (localPath != null) {
      final support = await getApplicationSupportDirectory();
      final assetsRoot = p.normalize(p.join(support.path, 'assets'));
      final resolved = p.normalize(p.absolute(localPath));
      if (!p.isWithin(assetsRoot, resolved)) {
        throw StateError('Refusing to remove an asset outside app storage.');
      }
      final file = File(resolved);
      if (file.existsSync()) await file.delete();
    }
    await _databases.app.customStatement(
      'DELETE FROM downloaded_assets WHERE asset_id = ?',
      <Object?>[assetId],
    );
    await _databases.archive.customStatement(
      "UPDATE document_files SET local_path = NULL, download_state = 'not_downloaded' WHERE id = ?",
      <Object?>[assetId],
    );
  }

  @override
  Future<List<SearchHit>> search(
    String query, {
    String? collectionId,
    int limit = 50,
  }) async {
    final terms = query
        .trim()
        .split(RegExp(r'\s+'))
        .where((term) => term.isNotEmpty)
        .take(12)
        .map((term) => '"${term.replaceAll('"', '""')}"*')
        .join(' ');
    if (terms.isEmpty) return const <SearchHit>[];
    final filter = collectionId == null ? '' : 'AND collection_id = ?';
    final variables = <Variable<Object>>[
      Variable<String>(terms),
      if (collectionId != null) Variable<String>(collectionId),
      Variable<int>(limit),
    ];
    final rows = await _databases.archive
        .customSelect(
          'SELECT collection_id, collection_name, document_id, document_title, block_id, '
          'NULLIF(block_label, \'\') AS block_label, '
          "snippet(search_index, 6, '<mark>', '</mark>', '…', 18) AS result_snippet, "
          'bm25(search_index, 0.0, 0.3, 0.0, 5.0, 0.0, 2.0, 1.0) AS score '
          'FROM search_index WHERE search_index MATCH ? $filter ORDER BY score LIMIT ?',
          variables: variables,
        )
        .get();
    final hits = <SearchHit>[];
    for (final row in rows) {
      final blockId = row.read<String>('block_id');
      final verse = await _databases.archive
          .customSelect(
            'SELECT book_id, chapter, verse FROM bible_verses WHERE block_id = ?',
            variables: <Variable<Object>>[Variable<String>(blockId)],
          )
          .getSingleOrNull();
      hits.add(
        SearchHit(
          collectionId: row.read<String>('collection_id'),
          collectionName: row.read<String>('collection_name'),
          documentId: row.read<String>('document_id'),
          documentTitle: row.read<String>('document_title'),
          blockId: blockId,
          blockLabel: row.readNullable<String>('block_label'),
          snippet: row.read<String>('result_snippet'),
          score: row.read<double>('score'),
          bibleBookId: verse?.read<String>('book_id'),
          bibleChapter: verse?.read<int>('chapter'),
          bibleVerse: verse?.read<int>('verse'),
        ),
      );
    }
    return hits;
  }

  @override
  Future<List<BookmarkRecord>> getBookmarks() async {
    final rows = await _databases.app
        .customSelect('SELECT * FROM bookmarks ORDER BY created_at DESC')
        .get();
    return rows
        .map(
          (row) => BookmarkRecord(
            id: row.read<String>('id'),
            documentId: row.read<String>('document_id'),
            documentTitle: row.read<String>('document_title'),
            blockId: row.readNullable<String>('block_id'),
            label: row.readNullable<String>('label'),
            createdAt: DateTime.parse(row.read<String>('created_at')),
          ),
        )
        .toList();
  }

  @override
  Future<bool> isBookmarked(String documentId, {String? blockId}) async {
    final blockClause = blockId == null ? 'block_id IS NULL' : 'block_id = ?';
    final row = await _databases.app
        .customSelect(
          'SELECT 1 AS found FROM bookmarks WHERE document_id = ? AND $blockClause LIMIT 1',
          variables: <Variable<Object>>[
            Variable<String>(documentId),
            if (blockId != null) Variable<String>(blockId),
          ],
        )
        .getSingleOrNull();
    return row != null;
  }

  @override
  Future<void> toggleBookmark(
    ArchiveDocument document, {
    String? blockId,
  }) async {
    if (await isBookmarked(document.id, blockId: blockId)) {
      await _databases.app.customStatement(
        'DELETE FROM bookmarks WHERE document_id = ? AND block_id IS ?',
        <Object?>[document.id, blockId],
      );
      return;
    }
    await _databases.app.customStatement(
      'INSERT INTO bookmarks '
      '(id, document_id, document_title, block_id, created_at) VALUES (?, ?, ?, ?, ?)',
      <Object?>[
        _uuid.v4(),
        document.id,
        document.displayTitle,
        blockId,
        DateTime.now().toUtc().toIso8601String(),
      ],
    );
  }

  @override
  Future<List<HighlightRecord>> getHighlights({String? documentId}) async {
    final rows = await _databases.app
        .customSelect(
          'SELECT * FROM highlights ${documentId == null ? '' : 'WHERE document_id = ?'} '
          'ORDER BY updated_at DESC',
          variables: documentId == null
              ? const <Variable<Object>>[]
              : <Variable<Object>>[Variable<String>(documentId)],
        )
        .get();
    return rows
        .map(
          (row) => HighlightRecord(
            id: row.read<String>('id'),
            documentId: row.read<String>('document_id'),
            blockId: row.read<String>('block_id'),
            startOffset: row.read<int>('start_offset'),
            endOffset: row.read<int>('end_offset'),
            selectedText: row.read<String>('selected_text'),
            style: row.read<String>('style'),
            updatedAt: DateTime.parse(row.read<String>('updated_at')),
          ),
        )
        .toList();
  }

  @override
  Future<void> addHighlight({
    required String documentId,
    required String blockId,
    required int startOffset,
    required int endOffset,
    required String selectedText,
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();
    await _databases.app.customStatement(
      'INSERT INTO highlights '
      '(id, document_id, block_id, start_offset, end_offset, selected_text, style, created_at, updated_at) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        _uuid.v4(),
        documentId,
        blockId,
        startOffset,
        endOffset,
        selectedText,
        'gold',
        now,
        now,
      ],
    );
  }

  @override
  Future<List<NoteRecord>> getNotes({String? documentId}) async {
    final rows = await _databases.app
        .customSelect(
          'SELECT * FROM notes ${documentId == null ? '' : 'WHERE document_id = ?'} '
          'ORDER BY updated_at DESC',
          variables: documentId == null
              ? const <Variable<Object>>[]
              : <Variable<Object>>[Variable<String>(documentId)],
        )
        .get();
    return rows
        .map(
          (row) => NoteRecord(
            id: row.read<String>('id'),
            documentId: row.read<String>('document_id'),
            documentTitle: row.read<String>('document_title'),
            blockId: row.readNullable<String>('block_id'),
            highlightId: row.readNullable<String>('highlight_id'),
            body: row.read<String>('body'),
            updatedAt: DateTime.parse(row.read<String>('updated_at')),
          ),
        )
        .toList();
  }

  @override
  Future<void> addNote(
    ArchiveDocument document,
    String body, {
    String? blockId,
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();
    await _databases.app.customStatement(
      'INSERT INTO notes '
      '(id, document_id, document_title, block_id, body, created_at, updated_at) '
      'VALUES (?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        _uuid.v4(),
        document.id,
        document.displayTitle,
        blockId,
        body,
        now,
        now,
      ],
    );
  }

  @override
  Future<List<ReadingProgressRecord>> getReadingHistory() async {
    final rows = await _databases.app
        .customSelect(
          'SELECT * FROM reading_progress ORDER BY last_opened_at DESC',
        )
        .get();
    return rows
        .map(
          (row) => ReadingProgressRecord(
            documentId: row.read<String>('document_id'),
            documentTitle: row.read<String>('document_title'),
            lastBlockId: row.readNullable<String>('last_block_id'),
            percentage: row.read<double>('percentage'),
            lastOpenedAt: DateTime.parse(row.read<String>('last_opened_at')),
            completed: row.read<int>('completed') == 1,
          ),
        )
        .toList();
  }

  @override
  Future<void> saveProgress(
    ArchiveDocument document, {
    String? blockId,
    required double percentage,
  }) async {
    final safePercentage = percentage.clamp(0.0, 1.0);
    await _databases.app.customStatement(
      'INSERT OR REPLACE INTO reading_progress '
      '(document_id, document_title, last_block_id, percentage, last_opened_at, completed) '
      'VALUES (?, ?, ?, ?, ?, ?)',
      <Object?>[
        document.id,
        document.displayTitle,
        blockId,
        safePercentage,
        DateTime.now().toUtc().toIso8601String(),
        safePercentage >= 0.98 ? 1 : 0,
      ],
    );
  }

  @override
  Future<String?> getValue(String key) async {
    final row = await _databases.app
        .customSelect(
          'SELECT value FROM settings WHERE setting_key = ?',
          variables: <Variable<Object>>[Variable<String>(key)],
        )
        .getSingleOrNull();
    return row?.read<String>('value');
  }

  @override
  Future<void> setValue(String key, String value) =>
      _databases.app.customStatement(
        'INSERT OR REPLACE INTO settings (setting_key, value) VALUES (?, ?)',
        <Object?>[key, value],
      );

  Future<List<String>> getTopics() async {
    final rows = await _databases.archive
        .customSelect('SELECT name FROM topics ORDER BY name')
        .get();
    return rows.map((row) => row.read<String>('name')).toList();
  }

  Future<List<ScriptureReferenceRecord>> getScriptureReferences() async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT * FROM scripture_references ORDER BY book, chapter, verse_start',
        )
        .get();
    return rows
        .map(
          (row) => ScriptureReferenceRecord(
            documentId: row.read<String>('document_id'),
            blockId: row.read<String>('block_id'),
            book: row.read<String>('book'),
            chapter: row.read<int>('chapter'),
            verseStart: row.read<int>('verse_start'),
            verseEnd: row.readNullable<int>('verse_end'),
            canonicalReference: row.read<String>('canonical_reference'),
          ),
        )
        .toList();
  }

  Future<List<TimelineRecord>> getTimeline() async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT timeline_entries.document_id, documents.display_title, '
          'timeline_entries.date, timeline_entries.date_type '
          'FROM timeline_entries JOIN documents ON documents.id = timeline_entries.document_id '
          'ORDER BY timeline_entries.date DESC',
        )
        .get();
    return rows
        .map(
          (row) => TimelineRecord(
            documentId: row.read<String>('document_id'),
            documentTitle: row.read<String>('display_title'),
            date: row.read<String>('date'),
            dateType: row.read<String>('date_type'),
          ),
        )
        .toList();
  }

  Future<List<CrossReferenceRecord>> getCrossReferences(
    String documentId,
  ) async {
    final rows = await _databases.archive
        .customSelect(
          'SELECT cross_references.*, cross_references.target_document_id AS linked_document_id, '
          'documents.display_title AS linked_title, '
          "'referenced' AS direction FROM cross_references "
          'JOIN documents ON documents.id = cross_references.target_document_id '
          'WHERE cross_references.source_document_id = ? AND cross_references.verified = 1 '
          'UNION ALL '
          'SELECT cross_references.*, cross_references.source_document_id AS linked_document_id, '
          'documents.display_title AS linked_title, '
          "'referenced_by' AS direction FROM cross_references "
          'JOIN documents ON documents.id = cross_references.source_document_id '
          'WHERE cross_references.target_document_id = ? AND cross_references.verified = 1',
          variables: <Variable<Object>>[
            Variable<String>(documentId),
            Variable<String>(documentId),
          ],
        )
        .get();
    return rows
        .map(
          (row) => CrossReferenceRecord(
            id: row.read<String>('id'),
            sourceDocumentId: row.read<String>('source_document_id'),
            sourceBlockId: row.readNullable<String>('source_block_id'),
            linkedDocumentId: row.read<String>('linked_document_id'),
            linkedDocumentTitle: row.read<String>('linked_title'),
            relationshipType: row.read<String>('relationship_type'),
            displayText: row.read<String>('display_text'),
            direction: row.read<String>('direction'),
          ),
        )
        .toList();
  }

  Future<StorageSummary> getStorageSummary() async {
    final textRows = await _databases.app
        .customSelect(
          "SELECT collection_id, total_bytes FROM downloaded_collections WHERE state IN ('downloaded', 'update_available')",
        )
        .get();
    final assetRows = await _databases.app
        .customSelect(
          'SELECT downloaded_assets.file_type, downloaded_assets.file_size, documents.collection_id '
          'FROM downloaded_assets LEFT JOIN documents '
          'ON documents.id = downloaded_assets.document_id',
        )
        .get();
    var textBytes = 0;
    var cleanPdfBytes = 0;
    var originalScanBytes = 0;
    var audioBytes = 0;
    var otherAssetBytes = 0;
    final byCollection = <String, int>{};
    for (final row in textRows) {
      final bytes = row.read<int>('total_bytes');
      final collectionId = row.read<String>('collection_id');
      textBytes += bytes;
      byCollection.update(
        collectionId,
        (value) => value + bytes,
        ifAbsent: () => bytes,
      );
    }
    for (final row in assetRows) {
      final bytes = row.read<int>('file_size');
      final fileType = row.read<String>('file_type');
      if (fileType == 'clean_pdf' || fileType == 'pdf') {
        cleanPdfBytes += bytes;
      } else if (fileType == 'original_scan') {
        originalScanBytes += bytes;
      } else if (<String>{
        'audio',
        'mp3',
        'm4a',
        'aac',
        'wav',
        'ogg',
        'flac',
        'opus',
      }.contains(fileType)) {
        audioBytes += bytes;
      } else {
        otherAssetBytes += bytes;
      }
      final collectionId = row.readNullable<String>('collection_id');
      if (collectionId != null) {
        byCollection.update(
          collectionId,
          (value) => value + bytes,
          ifAbsent: () => bytes,
        );
      }
    }
    return StorageSummary(
      textBytes: textBytes,
      cleanPdfBytes: cleanPdfBytes,
      originalScanBytes: originalScanBytes,
      audioBytes: audioBytes,
      otherAssetBytes: otherAssetBytes,
      byCollection: byCollection,
    );
  }

  Future<void> deletePersonalStudyData() async {
    await _databases.app.transaction(() async {
      await _databases.app.customStatement('DELETE FROM bookmarks');
      await _databases.app.customStatement('DELETE FROM highlights');
      await _databases.app.customStatement('DELETE FROM notes');
      await _databases.app.customStatement('DELETE FROM reading_progress');
      await _databases.app.customStatement(
        "DELETE FROM settings WHERE setting_key LIKE 'audio_position:%'",
      );
    });
  }
}

class _DownloadCancelled implements Exception {
  const _DownloadCancelled();
}

String _formatStorageBytes(int bytes) => bytes < 1024 * 1024
    ? '${(bytes / 1024).ceil()} KB'
    : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
