import 'dart:convert';

typedef Json = Map<String, Object?>;

class CollectionCapabilities {
  const CollectionCapabilities({
    required this.responsiveText,
    required this.cleanPdf,
    required this.originalScan,
    required this.audio,
    required this.video,
    required this.bibleReader,
    required this.verseNavigation,
    required this.search,
  });

  factory CollectionCapabilities.fromJson(
    Object? value, {
    required String collectionType,
  }) {
    final json = value is Json ? value : const <String, Object?>{};
    final bible = collectionType == 'bible';
    final audio = collectionType == 'audio';
    return CollectionCapabilities(
      responsiveText: json['responsiveText'] as bool? ?? !audio,
      cleanPdf: json['cleanPdf'] as bool? ?? false,
      originalScan: json['originalScan'] as bool? ?? false,
      audio: json['audio'] as bool? ?? audio,
      video: json['video'] as bool? ?? false,
      bibleReader: json['bibleReader'] as bool? ?? bible,
      verseNavigation: json['verseNavigation'] as bool? ?? bible,
      search: json['search'] as bool? ?? true,
    );
  }

  final bool responsiveText;
  final bool cleanPdf;
  final bool originalScan;
  final bool audio;
  final bool video;
  final bool bibleReader;
  final bool verseNavigation;
  final bool search;

  Json toJson() => <String, Object?>{
    'responsiveText': responsiveText,
    'cleanPdf': cleanPdf,
    'originalScan': originalScan,
    'audio': audio,
    'video': video,
    'bibleReader': bibleReader,
    'verseNavigation': verseNavigation,
    'search': search,
  };
}

class PackDescriptor {
  const PackDescriptor({
    required this.url,
    required this.fileSize,
    required this.sha256,
    required this.version,
  });

  factory PackDescriptor.fromJson(Json json) => PackDescriptor(
    url: json['url']! as String,
    fileSize: (json['fileSize']! as num).toInt(),
    sha256: json['sha256']! as String,
    version: (json['version']! as num).toInt(),
  );

  final String url;
  final int fileSize;
  final String sha256;
  final int version;
}

class CollectionSummary {
  const CollectionSummary({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.collectionType,
    required this.displayOrder,
    required this.documentCount,
    required this.uniqueItemCount,
    required this.contentVersion,
    required this.downloadSize,
    this.pack,
    this.manifestPath,
    this.iconUrl,
    this.coverUrl,
    this.thumbnailUrl,
    this.translationCode,
    this.sortMode = 'ascending',
    this.capabilities = const CollectionCapabilities(
      responsiveText: true,
      cleanPdf: false,
      originalScan: false,
      audio: false,
      video: false,
      bibleReader: false,
      verseNavigation: false,
      search: true,
    ),
    this.metadata = const <String, Object?>{},
  });

  factory CollectionSummary.fromJson(Json json, {required int index}) {
    final id = json['id']! as String;
    final documentCount = _firstInt(json, const <String>[
      'documentCount',
      'documentParts',
      'alertCount',
    ]);
    final uniqueItemCount = _firstInt(json, const <String>[
      'uniqueItemCount',
      'uniqueScrollCount',
      'alertCount',
      'documentCount',
    ]);
    final packJson = json['pack'];
    final collectionType =
        json['collectionType'] as String? ?? _legacyCollectionType(id);
    return CollectionSummary(
      id: id,
      slug: json['slug'] as String? ?? id,
      name: json['name']! as String,
      description:
          json['description'] as String? ?? 'Available from the archive.',
      collectionType: collectionType,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? index + 1,
      documentCount: documentCount,
      uniqueItemCount: uniqueItemCount,
      contentVersion: (json['contentVersion'] as num?)?.toInt() ?? 1,
      downloadSize: (json['downloadSize'] as num?)?.toInt() ?? 0,
      pack: packJson is Json ? PackDescriptor.fromJson(packJson) : null,
      manifestPath: json['manifest'] as String?,
      iconUrl: _firstString(json, const <String>['icon', 'iconUrl']),
      coverUrl: _firstString(json, const <String>['cover', 'coverUrl']),
      thumbnailUrl: _firstString(json, const <String>[
        'thumbnail',
        'thumbnailUrl',
      ]),
      translationCode: _firstString(json, const <String>[
        'translationCode',
        'translation',
      ]),
      sortMode: json['sortMode'] as String? ?? 'ascending',
      capabilities: CollectionCapabilities.fromJson(
        json['capabilities'],
        collectionType: collectionType,
      ),
      metadata: Map<String, Object?>.unmodifiable(json),
    );
  }

  final String id;
  final String slug;
  final String name;
  final String description;
  final String collectionType;
  final int displayOrder;
  final int documentCount;
  final int uniqueItemCount;
  final int contentVersion;
  final int downloadSize;
  final PackDescriptor? pack;
  final String? manifestPath;
  final String? iconUrl;
  final String? coverUrl;
  final String? thumbnailUrl;
  final String? translationCode;
  final String sortMode;
  final CollectionCapabilities capabilities;
  final Json metadata;

  String get countLabel => collectionType == 'prophetic_scrolls'
      ? '$uniqueItemCount Scrolls'
      : '$uniqueItemCount ${uniqueItemCount == 1 ? 'item' : 'items'}';
}

class ArchiveCatalogue {
  const ArchiveCatalogue({
    required this.schemaVersion,
    required this.catalogueVersion,
    required this.developmentFixture,
    required this.collections,
  });

  factory ArchiveCatalogue.fromJson(Json json) {
    final schemaVersion = (json['schemaVersion']! as num).toInt();
    if (schemaVersion != 1) {
      throw FormatException('Unsupported catalogue schema $schemaVersion');
    }
    final developmentFixture = json['developmentFixture'] == true;
    final collections =
        (json['collections']! as List<Object?>)
            .cast<Json>()
            .toList()
            .asMap()
            .entries
            .map(
              (entry) =>
                  CollectionSummary.fromJson(entry.value, index: entry.key),
            )
            .toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    final ids = collections.map((item) => item.id).toSet();
    if (ids.length != collections.length) {
      throw const FormatException('Duplicate collection id');
    }
    final slugs = <String>{};
    final displayOrders = <int>{};
    final stableId = RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');
    final sha256Pattern = RegExp(r'^[a-fA-F0-9]{64}$');
    for (final collection in collections) {
      if (!stableId.hasMatch(collection.id) ||
          !stableId.hasMatch(collection.slug)) {
        throw FormatException(
          'Invalid stable collection id or slug: ${collection.id}',
        );
      }
      if (!slugs.add(collection.slug) ||
          !displayOrders.add(collection.displayOrder)) {
        throw const FormatException(
          'Collection slugs and display orders must be unique.',
        );
      }
      if (collection.documentCount < 0 ||
          collection.uniqueItemCount < 0 ||
          collection.contentVersion < 1 ||
          collection.downloadSize < 0) {
        throw FormatException(
          'Invalid count, size, or version for ${collection.id}.',
        );
      }
      final pack = collection.pack;
      final manifestPath = collection.manifestPath;
      if ((pack == null) == (manifestPath == null)) {
        throw FormatException(
          '${collection.id} must define exactly one pack or manifest.',
        );
      }
      if (pack != null &&
          (pack.fileSize < 1 ||
              pack.version != collection.contentVersion ||
              !sha256Pattern.hasMatch(pack.sha256) ||
              !Uri.parse(pack.url).isScheme('https') &&
                  Uri.parse(pack.url).hasScheme)) {
        throw FormatException('Invalid pack descriptor for ${collection.id}.');
      }
      if (manifestPath != null &&
          (manifestPath.isEmpty ||
              manifestPath.startsWith('/') ||
              manifestPath.contains('..'))) {
        throw FormatException('Invalid manifest path for ${collection.id}.');
      }
      if (collection.collectionType == 'prophetic_scrolls' &&
          collection.uniqueItemCount != 320) {
        throw const FormatException(
          'The Prophetic Scrolls catalogue must contain 320 unique Scrolls.',
        );
      }
    }
    return ArchiveCatalogue(
      schemaVersion: schemaVersion,
      catalogueVersion: (json['catalogueVersion'] as num?)?.toInt() ?? 1,
      developmentFixture: developmentFixture,
      collections: collections,
    );
  }

  factory ArchiveCatalogue.decode(String value) =>
      ArchiveCatalogue.fromJson(jsonDecode(value) as Json);

  final int schemaVersion;
  final int catalogueVersion;
  final bool developmentFixture;
  final List<CollectionSummary> collections;
}

int _firstInt(Json json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is num) return value.toInt();
  }
  return 0;
}

String? _firstString(Json json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is String && value.trim().isNotEmpty) return value;
  }
  return null;
}

String _legacyCollectionType(String id) => switch (id) {
  'prophetic-scrolls' => 'prophetic_scrolls',
  'special-writings' => 'special_writings',
  'translation-alerts' => 'translation_alerts',
  'monthly-letters' => 'monthly_letters',
  _ => 'documents',
};

class DocumentAsset {
  const DocumentAsset({
    required this.id,
    required this.fileType,
    required this.version,
    this.assetPath,
    this.localPath,
    this.remoteUrl,
    this.fileSize,
    this.sha256,
    this.durationSeconds,
    this.mimeType,
    this.title,
    this.trackNumber,
    this.metadata = const <String, Object?>{},
    this.downloadState = 'not_downloaded',
  });

  factory DocumentAsset.fromJson(Json json) => DocumentAsset(
    id: json['id']! as String,
    fileType: (json['fileType'] ?? json['type'])! as String,
    version: (json['version'] as num?)?.toInt() ?? 1,
    assetPath: json['assetPath'] as String?,
    localPath: json['localPath'] as String?,
    remoteUrl: (json['remoteUrl'] ?? json['url']) as String?,
    fileSize: ((json['fileSize'] ?? json['size_bytes']) as num?)?.toInt(),
    sha256: json['sha256'] as String?,
    durationSeconds:
        ((json['durationSeconds'] ?? json['duration_seconds']) as num?)
            ?.toInt(),
    mimeType: json['mimeType'] as String?,
    title: json['title'] as String?,
    trackNumber: (json['trackNumber'] as num?)?.toInt(),
    metadata: Map<String, Object?>.unmodifiable(json),
    downloadState: json['downloadState'] as String? ?? 'not_downloaded',
  );

  final String id;
  final String fileType;
  final int version;
  final String? assetPath;
  final String? localPath;
  final String? remoteUrl;
  final int? fileSize;
  final String? sha256;
  final int? durationSeconds;
  final String? mimeType;
  final String? title;
  final int? trackNumber;
  final Json metadata;
  final String downloadState;

  bool get isAvailable => assetPath != null || localPath != null;
  bool get isAudio =>
      fileType == 'audio' ||
      fileType.startsWith('audio_') ||
      const <String>{
        'mp3',
        'm4a',
        'aac',
        'wav',
        'ogg',
        'flac',
        'opus',
      }.contains(fileType);
}

class DocumentBlock {
  const DocumentBlock({
    required this.id,
    required this.documentId,
    required this.orderIndex,
    required this.blockType,
    required this.text,
    this.numberLabel,
    this.headingLevel,
    this.metadata = const <String, Object?>{},
  });

  final String id;
  final String documentId;
  final int orderIndex;
  final String blockType;
  final String text;
  final String? numberLabel;
  final int? headingLevel;
  final Json metadata;

  String get label => numberLabel == null ? '' : 'Point $numberLabel';
}

class ArchiveDocument {
  const ArchiveDocument({
    required this.id,
    required this.collectionId,
    required this.slug,
    required this.displayTitle,
    required this.documentType,
    required this.sortOrder,
    required this.hasResponsiveText,
    required this.hasCleanPdf,
    required this.hasOriginalScan,
    required this.contentVersion,
    required this.numberVerified,
    required this.assets,
    this.documentNumber,
    this.parentNumber,
    this.partNumber,
    this.partLabel,
    this.subtitle,
    this.author,
    this.speaker,
    this.publicationDate,
    this.year,
    this.month,
    this.metadata = const <String, Object?>{},
  });

  final String id;
  final String collectionId;
  final String slug;
  final String displayTitle;
  final String documentType;
  final int? documentNumber;
  final int? parentNumber;
  final int? partNumber;
  final String? partLabel;
  final String? subtitle;
  final String? author;
  final String? speaker;
  final String? publicationDate;
  final int? year;
  final int? month;
  final int sortOrder;
  final bool hasResponsiveText;
  final bool hasCleanPdf;
  final bool hasOriginalScan;
  final int contentVersion;
  final bool numberVerified;
  final List<DocumentAsset> assets;
  final Json metadata;

  bool get isPage => documentType == 'page';
  bool get isMultipart => partNumber != null;
  bool get showsPdf => hasCleanPdf && documentType != 'scroll';
  int get groupingNumber => parentNumber ?? documentNumber ?? sortOrder;
  List<DocumentAsset> get audioAssets =>
      assets.where((asset) => asset.isAudio).toList(growable: false);
  bool get hasAudio => audioAssets.isNotEmpty;
  String? get bibleBookId => metadata['bookId'] as String?;
  int? get bibleChapter => (metadata['chapter'] as num?)?.toInt();
}

class SearchHit {
  const SearchHit({
    required this.collectionId,
    required this.collectionName,
    required this.documentId,
    required this.documentTitle,
    required this.blockId,
    required this.blockLabel,
    required this.snippet,
    required this.score,
    this.bibleBookId,
    this.bibleChapter,
    this.bibleVerse,
  });

  final String collectionId;
  final String collectionName;
  final String documentId;
  final String documentTitle;
  final String blockId;
  final String? blockLabel;
  final String snippet;
  final double score;
  final String? bibleBookId;
  final int? bibleChapter;
  final int? bibleVerse;
}

class DownloadJob {
  const DownloadJob({
    required this.collectionId,
    required this.contentVersion,
    required this.state,
    required this.downloadedBytes,
    required this.totalBytes,
    this.errorMessage,
  });

  final String collectionId;
  final int contentVersion;
  final String state;
  final int downloadedBytes;
  final int totalBytes;
  final String? errorMessage;

  double? get progress =>
      totalBytes <= 0 ? null : (downloadedBytes / totalBytes).clamp(0.0, 1.0);
}

class BookmarkRecord {
  const BookmarkRecord({
    required this.id,
    required this.documentId,
    required this.documentTitle,
    required this.createdAt,
    this.blockId,
    this.label,
  });

  final String id;
  final String documentId;
  final String documentTitle;
  final String? blockId;
  final String? label;
  final DateTime createdAt;
}

class NoteRecord {
  const NoteRecord({
    required this.id,
    required this.documentId,
    required this.documentTitle,
    required this.body,
    required this.updatedAt,
    this.blockId,
    this.highlightId,
  });

  final String id;
  final String documentId;
  final String documentTitle;
  final String? blockId;
  final String? highlightId;
  final String body;
  final DateTime updatedAt;
}

class HighlightRecord {
  const HighlightRecord({
    required this.id,
    required this.documentId,
    required this.blockId,
    required this.startOffset,
    required this.endOffset,
    required this.selectedText,
    required this.style,
    required this.updatedAt,
  });

  final String id;
  final String documentId;
  final String blockId;
  final int startOffset;
  final int endOffset;
  final String selectedText;
  final String style;
  final DateTime updatedAt;
}

class ReadingProgressRecord {
  const ReadingProgressRecord({
    required this.documentId,
    required this.documentTitle,
    required this.percentage,
    required this.lastOpenedAt,
    required this.completed,
    this.lastBlockId,
  });

  final String documentId;
  final String documentTitle;
  final String? lastBlockId;
  final double percentage;
  final DateTime lastOpenedAt;
  final bool completed;
}

class ScriptureReferenceRecord {
  const ScriptureReferenceRecord({
    required this.documentId,
    required this.blockId,
    required this.book,
    required this.chapter,
    required this.verseStart,
    required this.canonicalReference,
    this.verseEnd,
  });

  final String documentId;
  final String blockId;
  final String book;
  final int chapter;
  final int verseStart;
  final int? verseEnd;
  final String canonicalReference;
}

class ScriptureOccurrence {
  const ScriptureOccurrence({
    required this.spanId,
    required this.collectionId,
    required this.collectionName,
    required this.documentId,
    required this.documentTitle,
    required this.blockId,
    required this.blockText,
    required this.rawText,
    required this.startOffset,
    required this.endOffset,
    required this.bookId,
    required this.chapter,
    this.verse,
    this.blockLabel,
    this.chapterOnly = false,
  });

  final String spanId;
  final String collectionId;
  final String collectionName;
  final String documentId;
  final String documentTitle;
  final String blockId;
  final String blockText;
  final String rawText;
  final int startOffset;
  final int endOffset;
  final String bookId;
  final int chapter;
  final int? verse;
  final String? blockLabel;
  final bool chapterOnly;

  String get snippet {
    final start = (startOffset - 90).clamp(0, blockText.length);
    final end = (endOffset + 90).clamp(start, blockText.length);
    return '${start > 0 ? '…' : ''}${blockText.substring(start, end).trim()}${end < blockText.length ? '…' : ''}';
  }
}

class TimelineRecord {
  const TimelineRecord({
    required this.documentId,
    required this.documentTitle,
    required this.date,
    required this.dateType,
  });

  final String documentId;
  final String documentTitle;
  final String date;
  final String dateType;
}

class CrossReferenceRecord {
  const CrossReferenceRecord({
    required this.id,
    required this.sourceDocumentId,
    required this.linkedDocumentId,
    required this.linkedDocumentTitle,
    required this.relationshipType,
    required this.displayText,
    required this.direction,
    this.sourceBlockId,
  });

  final String id;
  final String sourceDocumentId;
  final String? sourceBlockId;
  final String linkedDocumentId;
  final String linkedDocumentTitle;
  final String relationshipType;
  final String displayText;
  final String direction;
}

class StorageSummary {
  const StorageSummary({
    required this.textBytes,
    required this.cleanPdfBytes,
    required this.originalScanBytes,
    this.audioBytes = 0,
    this.otherAssetBytes = 0,
    required this.byCollection,
  });

  final int textBytes;
  final int cleanPdfBytes;
  final int originalScanBytes;
  final int audioBytes;
  final int otherAssetBytes;
  final Map<String, int> byCollection;

  int get totalBytes =>
      textBytes +
      cleanPdfBytes +
      originalScanBytes +
      audioBytes +
      otherAssetBytes;
}

class BibleBook {
  const BibleBook({
    required this.id,
    required this.name,
    required this.order,
    required this.testament,
    required this.chapterCount,
  });

  final String id;
  final String name;
  final int order;
  final String testament;
  final int chapterCount;
}

class BibleVerse {
  const BibleVerse({
    required this.id,
    required this.collectionId,
    required this.translationCode,
    required this.bookId,
    required this.bookName,
    required this.bookOrder,
    required this.chapter,
    required this.verse,
    required this.text,
    required this.documentId,
    required this.blockId,
  });

  final String id;
  final String collectionId;
  final String translationCode;
  final String bookId;
  final String bookName;
  final int bookOrder;
  final int chapter;
  final int verse;
  final String text;
  final String documentId;
  final String blockId;

  String get reference => '$bookName $chapter:$verse';
}

class BibleReferenceTarget {
  const BibleReferenceTarget({
    required this.collectionId,
    required this.collectionName,
    required this.translationCode,
    required this.bookId,
    required this.bookName,
    required this.chapter,
    this.verse,
    this.verseEnd,
  });

  final String collectionId;
  final String collectionName;
  final String translationCode;
  final String bookId;
  final String bookName;
  final int chapter;
  final int? verse;
  final int? verseEnd;

  String get reference =>
      '$bookName $chapter'
      '${verse == null ? '' : ':$verse${verseEnd == null ? '' : '-$verseEnd'}'}';
}

class AiSource {
  const AiSource({
    required this.sourceId,
    required this.collection,
    required this.document,
    required this.text,
    this.blockLabel,
  });

  final String sourceId;
  final String collection;
  final String document;
  final String? blockLabel;
  final String text;

  Json toJson() => <String, Object?>{
    'sourceId': sourceId,
    'collection': collection,
    'document': document,
    'blockLabel': blockLabel,
    'text': text,
  };
}

class AiAnswer {
  const AiAnswer({required this.answer, required this.citationIds});

  final String answer;
  final List<String> citationIds;
}
