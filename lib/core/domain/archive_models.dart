import 'dart:convert';

typedef Json = Map<String, Object?>;

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
    return CollectionSummary(
      id: id,
      slug: json['slug'] as String? ?? id,
      name: json['name']! as String,
      description:
          json['description'] as String? ?? 'Available from the archive.',
      collectionType:
          json['collectionType'] as String? ?? id.replaceAll('-', '_'),
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? index + 1,
      documentCount: documentCount,
      uniqueItemCount: uniqueItemCount,
      contentVersion: (json['contentVersion'] as num?)?.toInt() ?? 1,
      downloadSize: (json['downloadSize'] as num?)?.toInt() ?? 0,
      pack: packJson is Json ? PackDescriptor.fromJson(packJson) : null,
      manifestPath: json['manifest'] as String?,
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
    this.downloadState = 'not_downloaded',
  });

  factory DocumentAsset.fromJson(Json json) => DocumentAsset(
    id: json['id']! as String,
    fileType: json['fileType']! as String,
    version: (json['version']! as num).toInt(),
    assetPath: json['assetPath'] as String?,
    localPath: json['localPath'] as String?,
    remoteUrl: json['remoteUrl'] as String?,
    fileSize: (json['fileSize'] as num?)?.toInt(),
    sha256: json['sha256'] as String?,
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
  final String downloadState;

  bool get isAvailable => assetPath != null || localPath != null;
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

  bool get isPage => documentType == 'page';
  bool get isMultipart => partNumber != null;
  int get groupingNumber => parentNumber ?? documentNumber ?? sortOrder;
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
  });

  final String collectionId;
  final String collectionName;
  final String documentId;
  final String documentTitle;
  final String blockId;
  final String? blockLabel;
  final String snippet;
  final double score;
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
    required this.byCollection,
  });

  final int textBytes;
  final int cleanPdfBytes;
  final int originalScanBytes;
  final Map<String, int> byCollection;

  int get totalBytes => textBytes + cleanPdfBytes + originalScanBytes;
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
