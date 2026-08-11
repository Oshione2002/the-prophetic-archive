import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/core/domain/archive_models.dart';
import 'package:the_prophetic_archive/core/domain/archive_rules.dart';

void main() {
  test('Pages sort before Scroll 1', () {
    final documents = <ArchiveDocument>[_scroll(1), _page()]
      ..sort(ArchiveRules.compareDocuments);
    expect(documents.map((item) => item.id), <String>[
      'page-001',
      'scroll-001',
    ]);
  });

  test('320 unique Scrolls remain 320 when Scroll 320 has two parts', () {
    final documents = <ArchiveDocument>[
      for (var number = 1; number <= 319; number++) _scroll(number),
      _scroll(320, part: 1),
      _scroll(320, part: 2),
    ];
    expect(ArchiveRules.countUniqueScrolls(documents), 320);
    final groups = ArchiveRules.groupMultipartScrolls(documents);
    expect(groups[320]!.map((item) => item.partNumber), <int?>[1, 2]);
    expect(documents.any((item) => item.documentNumber == 321), isFalse);
  });
}

ArchiveDocument _page() => const ArchiveDocument(
  id: 'page-001',
  collectionId: 'prophetic-scrolls',
  slug: 'page-001',
  displayTitle: 'Page 1',
  documentType: 'page',
  sortOrder: 1,
  hasResponsiveText: true,
  hasCleanPdf: true,
  hasOriginalScan: false,
  contentVersion: 1,
  numberVerified: false,
  assets: <DocumentAsset>[],
);

ArchiveDocument _scroll(int number, {int? part}) => ArchiveDocument(
  id: 'scroll-${number.toString().padLeft(3, '0')}${part == null ? '' : '-part-$part'}',
  collectionId: 'prophetic-scrolls',
  slug: 'scroll-$number',
  displayTitle: 'Scroll $number${part == null ? '' : ' - Part $part'}',
  documentType: 'scroll',
  documentNumber: number,
  parentNumber: number,
  partNumber: part,
  partLabel: part == null ? null : 'Part $part',
  sortOrder: number * 100 + (part ?? 0),
  hasResponsiveText: true,
  hasCleanPdf: false,
  hasOriginalScan: false,
  contentVersion: 1,
  numberVerified: true,
  assets: const <DocumentAsset>[],
);
