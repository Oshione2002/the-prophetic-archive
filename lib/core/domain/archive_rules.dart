import 'archive_models.dart';

abstract final class ArchiveRules {
  static int compareDocuments(ArchiveDocument a, ArchiveDocument b) {
    if (a.isPage != b.isPage) return a.isPage ? -1 : 1;
    final sort = a.sortOrder.compareTo(b.sortOrder);
    if (sort != 0) return sort;
    return (a.partNumber ?? 0).compareTo(b.partNumber ?? 0);
  }

  static int countUniqueScrolls(Iterable<ArchiveDocument> documents) {
    return documents
        .where((document) => document.documentType == 'scroll')
        .map((document) => document.parentNumber ?? document.documentNumber)
        .whereType<int>()
        .toSet()
        .length;
  }

  static Map<int, List<ArchiveDocument>> groupMultipartScrolls(
    Iterable<ArchiveDocument> documents,
  ) {
    final groups = <int, List<ArchiveDocument>>{};
    for (final document in documents.where((item) => item.partNumber != null)) {
      groups
          .putIfAbsent(document.groupingNumber, () => <ArchiveDocument>[])
          .add(document);
    }
    for (final parts in groups.values) {
      parts.sort((a, b) => (a.partNumber ?? 0).compareTo(b.partNumber ?? 0));
    }
    return groups;
  }
}
