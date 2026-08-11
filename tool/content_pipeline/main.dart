import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:the_prophetic_archive/core/domain/archive_models.dart';

Future<void> main(List<String> arguments) async {
  final root = Directory.current.path;
  final sourceArgument = _argument(arguments, '--source');
  final catalogueArgument = _argument(arguments, '--catalogue');
  final validateOnly = arguments.contains('--validate-only');
  if (sourceArgument == null && catalogueArgument == null && validateOnly) {
    final catalogueUrl =
        _argument(arguments, '--repository-catalogue') ??
        'https://raw.githubusercontent.com/Oshione2002/'
            'the-prophetic-archive-content/main/catalogue.json';
    try {
      await validatePublishedRepository(catalogueUrl);
    } catch (error) {
      stderr.writeln('ERROR: $error');
      exitCode = 1;
    }
    return;
  }
  if (sourceArgument == null || catalogueArgument == null) {
    stderr.writeln(
      'Usage: dart run tool/content_pipeline/main.dart '
      '--source <content.json> --catalogue <catalogue.json> [--output <dir>] '
      '[--validate-only]',
    );
    exitCode = 64;
    return;
  }
  final sourcePath = p.normalize(p.absolute(sourceArgument));
  final cataloguePath = p.normalize(p.absolute(catalogueArgument));
  final outputPath =
      _argument(arguments, '--output') ?? p.join(root, 'build', 'content');

  final source =
      jsonDecode(File(sourcePath).readAsStringSync()) as Map<String, Object?>;
  final catalogue =
      jsonDecode(File(cataloguePath).readAsStringSync())
          as Map<String, Object?>;
  final report = validateContent(source, catalogue);
  for (final message in report.messages) {
    stdout.writeln('${message.level.toUpperCase()}: ${message.text}');
  }
  if (!report.valid) exitCode = 1;
  if (!report.valid || validateOnly) return;

  final output = Directory(outputPath)..createSync(recursive: true);
  final builtCatalogue = buildContentPacks(source, catalogue, output);
  File(p.join(output.path, 'catalogue.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(builtCatalogue),
  );
  File(p.join(output.path, 'validation-report.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(report.toJson()),
  );
  stdout.writeln('Built validated content packs in ${output.path}');
}

Future<void> validatePublishedRepository(String catalogueUrl) async {
  final catalogueUri = Uri.parse(catalogueUrl);
  _requireRemoteUri(catalogueUri);
  final client = HttpClient()..userAgent = 'the-prophetic-archive-validator/1';
  try {
    final catalogueBody = await _readRemoteText(client, catalogueUri);
    final catalogue = ArchiveCatalogue.decode(catalogueBody);
    if (catalogue.developmentFixture) {
      throw const FormatException(
        'The published catalogue cannot contain development content.',
      );
    }
    var documentCount = 0;
    for (final collection in catalogue.collections) {
      final manifestPath = collection.manifestPath;
      if (manifestPath == null) {
        stdout.writeln('Validated packaged collection ${collection.id}.');
        continue;
      }
      final manifestUri = _withRefreshToken(catalogueUri.resolve(manifestPath));
      final manifest = _decodeObject(
        await _readRemoteText(client, manifestUri),
      );
      final schemaVersion =
          manifest['schemaVersion'] ?? manifest['schema_version'];
      final manifestCollectionId = manifest['id'] ?? manifest['collectionId'];
      if ((schemaVersion is num && schemaVersion.toInt() != 1) ||
          (schemaVersion != null && schemaVersion is! num) ||
          (manifestCollectionId != null &&
              manifestCollectionId != collection.id) ||
          (manifest['documents'] is! List &&
              manifest['contentPattern'] is! String)) {
        throw FormatException('Invalid manifest for ${collection.id}.');
      }
      final documentUris = await _publishedDocumentUris(
        client,
        catalogueUri,
        manifest,
      );
      if (documentUris.isEmpty) {
        throw FormatException(
          '${collection.id} does not publish any structured documents.',
        );
      }
      final ids = <String>{};
      const batchSize = 12;
      for (var offset = 0; offset < documentUris.length; offset += batchSize) {
        final end = offset + batchSize < documentUris.length
            ? offset + batchSize
            : documentUris.length;
        final documents = await Future.wait(
          documentUris.sublist(offset, end).map((documentUri) async {
            final document = _decodeObject(
              await _readRemoteText(client, documentUri, maximumBytes: 4 << 20),
            );
            return (uri: documentUri, document: document);
          }),
        );
        for (final result in documents) {
          final documentUri = result.uri;
          final document = result.document;
          final id = document['id'];
          final blocks = document['blocks'];
          if (id is! String ||
              !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id) ||
              !ids.add(id) ||
              ((document['collection'] ?? document['collectionId']) != null &&
                  (document['collection'] ?? document['collectionId']) !=
                      collection.id) ||
              blocks is! List<Object?> ||
              blocks.isEmpty) {
            throw FormatException(
              'Invalid published document at ${documentUri.path}.',
            );
          }
          final blockIds = <String>{};
          for (final block in blocks) {
            if (block is! Map ||
                block['id'] is! String ||
                !blockIds.add(block['id']! as String) ||
                block['text'] is! String) {
              throw FormatException('$id contains an invalid block.');
            }
          }
        }
      }
      documentCount += documentUris.length;
      stdout.writeln(
        'Validated ${documentUris.length} published documents in ${collection.name}.',
      );
    }
    stdout.writeln(
      'Validated $documentCount authentic published documents across '
      '${catalogue.collections.length} collections.',
    );
  } finally {
    client.close(force: true);
  }
}

Future<List<Uri>> _publishedDocumentUris(
  HttpClient client,
  Uri catalogueUri,
  Map<String, Object?> manifest,
) async {
  final declared = manifest['documents'];
  if (declared is List<Object?>) {
    final collectionId = manifest['id'] ?? manifest['collectionId'];
    if ((collectionId != null && collectionId is! String) || declared.isEmpty) {
      throw const FormatException('Manifest document list is invalid.');
    }
    final urls = <Uri>[];
    final ids = <String>{};
    for (final entry in declared) {
      if (entry is String) {
        urls.add(_withRefreshToken(catalogueUri.resolve(entry)));
        continue;
      }
      if (entry is! Map<String, Object?>) {
        throw const FormatException('Manifest document entry is invalid.');
      }
      final id = entry['id'];
      final assets = entry['assets'];
      final jsonAsset = assets is Map<String, Object?> ? assets['json'] : null;
      final fileName =
          entry['json'] ??
          (jsonAsset is Map<String, Object?> ? jsonAsset['file'] : null);
      if (id is! String ||
          !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id) ||
          !ids.add(id) ||
          fileName is! String ||
          !fileName.endsWith('.json') ||
          fileName.contains('\\') ||
          p.posix.basename(fileName) != fileName) {
        throw const FormatException('Manifest document entry is invalid.');
      }
      urls.add(
        _withRefreshToken(
          catalogueUri.resolve('content/${collectionId ?? ''}/$fileName'),
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
      'The catalogue host must list document URLs in its manifest.',
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
  final decoded = jsonDecode(await _readRemoteText(client, apiUri));
  if (decoded is! List<Object?>) {
    throw FormatException('Unable to list documents for ${manifest['id']}.');
  }
  final urls = <Uri>[];
  for (final entry in decoded) {
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
    'archive_refresh': DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
  },
);

Future<String> _readRemoteText(
  HttpClient client,
  Uri uri, {
  int maximumBytes = 1 << 20,
}) async {
  _requireRemoteUri(uri);
  final request = await client.getUrl(uri);
  request.headers.set(HttpHeaders.acceptHeader, 'application/vnd.github+json');
  request.headers.set(HttpHeaders.cacheControlHeader, 'no-cache');
  request.headers.set('pragma', 'no-cache');
  final githubToken = Platform.environment['GITHUB_TOKEN'];
  if (uri.host == 'api.github.com' &&
      githubToken != null &&
      githubToken.isNotEmpty) {
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $githubToken');
  }
  final response = await request.close();
  if (response.statusCode != HttpStatus.ok) {
    throw HttpException(
      'Request failed with HTTP ${response.statusCode}.',
      uri: uri,
    );
  }
  final bytes = <int>[];
  await for (final chunk in response) {
    bytes.addAll(chunk);
    if (bytes.length > maximumBytes) {
      throw const FormatException('Remote JSON exceeds the safe size limit.');
    }
  }
  return utf8.decode(bytes);
}

Map<String, Object?> _decodeObject(String source) {
  final decoded = jsonDecode(source);
  if (decoded is! Map<String, Object?>) {
    throw const FormatException('Expected a JSON object.');
  }
  return decoded;
}

void _requireRemoteUri(Uri uri) {
  final local =
      uri.scheme == 'http' &&
      (uri.host == 'localhost' || uri.host == '127.0.0.1');
  if (uri.scheme != 'https' && !local) {
    throw const FormatException('Content repository URLs must use HTTPS.');
  }
}

String? _argument(List<String> arguments, String name) {
  final index = arguments.indexOf(name);
  return index >= 0 && index + 1 < arguments.length
      ? arguments[index + 1]
      : null;
}

ValidationReport validateContent(
  Map<String, Object?> source,
  Map<String, Object?> catalogue,
) {
  final messages = <ValidationMessage>[];
  final developmentFixture = source['developmentFixture'] == true;
  if (source['schemaVersion'] != 1) {
    messages.add(
      const ValidationMessage('error', 'Unsupported content schema.'),
    );
  }
  if (catalogue['schemaVersion'] != 1) {
    messages.add(
      const ValidationMessage('error', 'Unsupported catalogue schema.'),
    );
  }
  final collectionIds = (catalogue['collections']! as List<Object?>)
      .cast<Map<String, Object?>>()
      .map((item) => item['id'])
      .whereType<String>()
      .toSet();
  if (collectionIds.contains('pages')) {
    messages.add(
      const ValidationMessage(
        'error',
        'Pages must not be a top-level collection.',
      ),
    );
  }
  final documents = (source['documents']! as List<Object?>)
      .cast<Map<String, Object?>>();
  final ids = <String>{};
  final assetIds = <String>{};
  for (final document in documents) {
    final id = document['id'] as String?;
    if (id == null || !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id)) {
      messages.add(
        ValidationMessage('error', 'Invalid stable document id: $id'),
      );
      continue;
    }
    if (!ids.add(id)) {
      messages.add(ValidationMessage('error', 'Duplicate document id: $id'));
    }
    if (!collectionIds.contains(document['collectionId'])) {
      messages.add(
        ValidationMessage('error', '$id references an unknown collection.'),
      );
    }
    final slug = document['slug'] as String?;
    if (slug == null || !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(slug)) {
      messages.add(ValidationMessage('error', '$id has an invalid slug.'));
    }
    final publicationDate = document['publicationDate'] as String?;
    if (publicationDate != null && DateTime.tryParse(publicationDate) == null) {
      messages.add(
        ValidationMessage('error', '$id has an invalid publication date.'),
      );
    }
    final blocks = ((document['blocks'] as List<Object?>?) ?? const <Object?>[])
        .cast<Map<String, Object?>>();
    final blockIds = <String>{};
    for (var index = 0; index < blocks.length; index++) {
      final block = blocks[index];
      final blockId = block['id'] as String?;
      if (blockId == null ||
          !blockId.startsWith('$id:') ||
          !blockIds.add(blockId)) {
        messages.add(
          ValidationMessage(
            'error',
            '$id has an invalid or duplicate block id.',
          ),
        );
      }
      if (block['orderIndex'] != index + 1) {
        messages.add(
          ValidationMessage(
            'error',
            '$id block order must be contiguous from 1.',
          ),
        );
      }
      if (document['documentType'] == 'translation_alert' &&
          block['type'] == 'numbered_item' &&
          (block['numberLabel'] as String?)?.isEmpty != false) {
        messages.add(
          ValidationMessage(
            'error',
            '$id has a numbered item without a numberLabel.',
          ),
        );
      }
    }
    final assets = ((document['assets'] as List<Object?>?) ?? const <Object?>[])
        .cast<Map<String, Object?>>();
    final types = assets.map((asset) => asset['fileType']).toSet();
    if (document['hasCleanPdf'] == true && !types.contains('clean_pdf')) {
      messages.add(
        ValidationMessage('error', '$id claims a PDF but supplies no asset.'),
      );
    }
    if (document['hasOriginalScan'] == true &&
        !types.contains('original_scan')) {
      messages.add(
        ValidationMessage(
          'error',
          '$id claims an Original Scan but supplies no asset.',
        ),
      );
    }
    if (document['documentType'] == 'page' &&
        document['hasOriginalScan'] == true) {
      messages.add(
        ValidationMessage(
          'error',
          '$id is a Page and cannot claim an Original Scan.',
        ),
      );
    }
    if (document['partNumber'] != null && document['parentNumber'] == null) {
      messages.add(
        ValidationMessage(
          'error',
          '$id has a partNumber without parentNumber metadata.',
        ),
      );
    }
    for (final asset in assets) {
      final assetId = asset['id'] as String?;
      final fileType = asset['fileType'] as String?;
      final version = asset['version'];
      if (assetId == null ||
          !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(assetId) ||
          !assetIds.add(assetId)) {
        messages.add(
          ValidationMessage(
            'error',
            '$id has an invalid or duplicate asset id.',
          ),
        );
      }
      if (fileType == null ||
          !RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(fileType) ||
          version is! num ||
          version.toInt() < 1) {
        messages.add(
          ValidationMessage('error', '$id has invalid asset metadata.'),
        );
      }
      final assetPath = asset['assetPath'] as String?;
      if (assetPath != null && !File(assetPath).existsSync()) {
        messages.add(
          ValidationMessage('error', '$id is missing asset $assetPath.'),
        );
      }
      final remoteUrl = asset['remoteUrl'] as String?;
      if (!developmentFixture &&
          (remoteUrl == null ||
              !remoteUrl.startsWith('https://') ||
              asset['fileSize'] is! num ||
              (asset['fileSize']! as num).toInt() < 1 ||
              asset['sha256'] is! String ||
              !RegExp(
                r'^[a-fA-F0-9]{64}$',
              ).hasMatch(asset['sha256']! as String))) {
        messages.add(
          ValidationMessage(
            'error',
            '$id production assets require HTTPS, size, and SHA-256.',
          ),
        );
      }
      if (assetPath != null && File(assetPath).existsSync()) {
        final bytes = File(assetPath).readAsBytesSync();
        if (asset['fileSize'] is num &&
            (asset['fileSize']! as num).toInt() != bytes.length) {
          messages.add(
            ValidationMessage('error', '$id asset size does not match.'),
          );
        }
        if (asset['sha256'] is String &&
            (asset['sha256']! as String).toLowerCase() !=
                sha256.convert(bytes).toString()) {
          messages.add(
            ValidationMessage('error', '$id asset checksum does not match.'),
          );
        }
      }
    }
  }
  if (documents.any((document) => document['collectionId'] == 'pages')) {
    messages.add(
      const ValidationMessage(
        'error',
        'Page documents must belong to prophetic-scrolls.',
      ),
    );
  }
  final crossReferenceIds = <String>{};
  for (final document in documents) {
    final documentId = document['id'] as String?;
    final blockIds =
        ((document['blocks'] as List<Object?>?) ?? const <Object?>[])
            .cast<Map<String, Object?>>()
            .map((block) => block['id'])
            .whereType<String>()
            .toSet();
    for (final reference
        in ((document['crossReferences'] as List<Object?>?) ??
                const <Object?>[])
            .cast<Map<String, Object?>>()) {
      final referenceId = reference['id'] as String?;
      final sourceBlockId = reference['sourceBlockId'] as String?;
      if (referenceId == null ||
          !referenceId.startsWith('$documentId:') ||
          !crossReferenceIds.add(referenceId) ||
          !ids.contains(reference['targetDocumentId']) ||
          (sourceBlockId != null && !blockIds.contains(sourceBlockId)) ||
          reference['verified'] != true) {
        messages.add(
          ValidationMessage(
            'error',
            '$documentId has an invalid or unverified cross-reference.',
          ),
        );
      }
    }
  }
  final collections = (catalogue['collections']! as List<Object?>)
      .cast<Map<String, Object?>>();
  for (final collection in collections) {
    final collectionId = collection['id'] as String?;
    final actualCount = documents
        .where((document) => document['collectionId'] == collectionId)
        .length;
    if (collection['documentCount'] != actualCount) {
      messages.add(
        ValidationMessage(
          'error',
          '$collectionId declares ${collection['documentCount']} documents but supplies $actualCount.',
        ),
      );
    }
  }
  final multipartGroups = <String, List<int>>{};
  for (final document in documents.where(
    (item) => item['partNumber'] != null,
  )) {
    final key = '${document['collectionId']}:${document['parentNumber']}';
    multipartGroups
        .putIfAbsent(key, () => <int>[])
        .add((document['partNumber']! as num).toInt());
  }
  for (final entry in multipartGroups.entries) {
    entry.value.sort();
    for (var index = 0; index < entry.value.length; index++) {
      if (entry.value[index] != index + 1) {
        messages.add(
          ValidationMessage(
            'error',
            '${entry.key} multipart numbering must be contiguous from Part 1.',
          ),
        );
        break;
      }
    }
  }
  if (messages.every((message) => message.level != 'error')) {
    messages.add(
      ValidationMessage(
        'info',
        'Validated ${documents.length} ${developmentFixture ? 'development' : 'production'} documents.',
      ),
    );
  }
  return ValidationReport(messages);
}

Map<String, Object?> buildContentPacks(
  Map<String, Object?> source,
  Map<String, Object?> catalogue,
  Directory output,
) {
  final documents = (source['documents']! as List<Object?>)
      .cast<Map<String, Object?>>();
  final collections = (catalogue['collections']! as List<Object?>)
      .cast<Map<String, Object?>>();
  final builtCollections = <Map<String, Object?>>[];
  for (final collection in collections) {
    final collectionId = collection['id']! as String;
    final selected = documents
        .where((document) => document['collectionId'] == collectionId)
        .toList();
    final workDirectory = Directory(p.join(output.path, '.$collectionId'))
      ..createSync(recursive: true);
    final databaseFile = File(p.join(workDirectory.path, 'content.sqlite'));
    if (databaseFile.existsSync()) databaseFile.deleteSync();
    final database = sqlite3.open(databaseFile.path);
    try {
      _createPackSchema(database);
      database.execute('BEGIN IMMEDIATE');
      database
          .execute('INSERT INTO pack_metadata VALUES (?, ?, ?, ?)', <Object?>[
            1,
            collectionId,
            collection['contentVersion'],
            source['developmentFixture'] == true ? 1 : 0,
          ]);
      for (final document in selected) {
        database.execute(
          'INSERT INTO documents VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          <Object?>[
            document['id'],
            document['collectionId'],
            document['displayTitle'],
            document['documentType'],
            document['documentNumber'],
            document['parentNumber'],
            document['partNumber'],
            document['sortOrder'],
            document['hasResponsiveText'] == true ? 1 : 0,
            document['hasCleanPdf'] == true ? 1 : 0,
            document['hasOriginalScan'] == true ? 1 : 0,
            document['publicationDate'],
            document['year'],
            document['month'],
          ],
        );
        for (final block
            in (document['blocks']! as List<Object?>)
                .cast<Map<String, Object?>>()) {
          database.execute(
            'INSERT INTO document_blocks VALUES (?, ?, ?, ?, ?, ?, ?)',
            <Object?>[
              block['id'],
              document['id'],
              block['orderIndex'],
              block['type'],
              block['text'],
              block['numberLabel'],
              block['headingLevel'],
            ],
          );
          database.execute('INSERT INTO search_index VALUES (?, ?, ?, ?, ?)', <
            Object?
          >[
            document['id'],
            document['displayTitle'],
            block['id'],
            block['numberLabel'] == null ? '' : 'Point ${block['numberLabel']}',
            block['text'],
          ]);
        }
      }
      database.execute('COMMIT');
    } catch (_) {
      database.execute('ROLLBACK');
      rethrow;
    } finally {
      database.close();
    }
    final packJson = utf8.encode(
      jsonEncode(<String, Object?>{
        'schemaVersion': 1,
        'collectionId': collectionId,
        'contentVersion': collection['contentVersion'],
        'documentCount': selected.length,
      }),
    );
    final databaseBytes = databaseFile.readAsBytesSync();
    final contentJson = utf8.encode(
      jsonEncode(<String, Object?>{
        'schemaVersion': 1,
        'developmentFixture': source['developmentFixture'] == true,
        'documents': selected,
      }),
    );
    final archive = Archive()
      ..addFile(
        ArchiveFile('content.sqlite', databaseBytes.length, databaseBytes),
      )
      ..addFile(ArchiveFile('pack.json', packJson.length, packJson))
      ..addFile(ArchiveFile('content.json', contentJson.length, contentJson));
    final zipBytes = ZipEncoder().encode(archive);
    final fileName = '$collectionId-v${collection['contentVersion']}.tpa.zip';
    File(p.join(output.path, fileName)).writeAsBytesSync(zipBytes, flush: true);
    final manifest = <String, Object?>{
      'schemaVersion': 1,
      'collectionId': collectionId,
      'contentVersion': collection['contentVersion'],
      'documents': selected,
    };
    File(
      p.join(output.path, '$collectionId.json'),
    ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifest));
    builtCollections.add(<String, Object?>{
      ...collection,
      'pack': <String, Object?>{
        'url': fileName,
        'fileSize': zipBytes.length,
        'sha256': sha256.convert(zipBytes).toString(),
        'version': collection['contentVersion'],
      },
    });
    databaseFile.deleteSync();
    workDirectory.deleteSync();
  }
  return <String, Object?>{
    ...catalogue,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    'collections': builtCollections,
  };
}

void _createPackSchema(Database database) {
  database.execute('''
    CREATE TABLE pack_metadata(schema_version INTEGER, collection_id TEXT, content_version INTEGER, development_fixture INTEGER);
    CREATE TABLE documents(id TEXT PRIMARY KEY, collection_id TEXT, display_title TEXT, document_type TEXT, document_number INTEGER, parent_number INTEGER, part_number INTEGER, sort_order INTEGER, has_responsive_text INTEGER, has_clean_pdf INTEGER, has_original_scan INTEGER, publication_date TEXT, year INTEGER, month INTEGER);
    CREATE TABLE document_blocks(id TEXT PRIMARY KEY, document_id TEXT, order_index INTEGER, block_type TEXT, block_text TEXT, number_label TEXT, heading_level INTEGER);
    CREATE VIRTUAL TABLE search_index USING fts5(document_id UNINDEXED, document_title, block_id UNINDEXED, block_label, body, tokenize='unicode61 remove_diacritics 2');
  ''');
}

class ValidationReport {
  const ValidationReport(this.messages);
  final List<ValidationMessage> messages;
  bool get valid => messages.every((message) => message.level != 'error');
  Map<String, Object?> toJson() => <String, Object?>{
    'valid': valid,
    'messages': messages.map((message) => message.toJson()).toList(),
  };
}

class ValidationMessage {
  const ValidationMessage(this.level, this.text);
  final String level;
  final String text;
  Map<String, Object?> toJson() => <String, Object?>{
    'level': level,
    'text': text,
  };
}
