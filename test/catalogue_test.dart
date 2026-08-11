import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/core/domain/archive_models.dart';
import 'package:the_prophetic_archive/core/theme/app_theme.dart';

void main() {
  test(
    'content-repository catalogue preserves the authoritative Scroll count',
    () {
      final catalogue = ArchiveCatalogue.decode('''
      {"schemaVersion":1,"collections":[
        {"id":"prophetic-scrolls","name":"Prophetic Scrolls","uniqueScrollCount":320,"documentParts":325,"manifest":"manifests/prophetic-scrolls.json"}
      ]}
    ''');
      final collection = catalogue.collections.single;
      expect(catalogue.catalogueVersion, 1);
      expect(collection.uniqueItemCount, 320);
      expect(collection.documentCount, 325);
      expect(collection.countLabel, '320 Scrolls');
      expect(collection.manifestPath, 'manifests/prophetic-scrolls.json');
    },
  );

  test('unsupported catalogue schema is rejected', () {
    expect(
      () => ArchiveCatalogue.decode(
        '{"schemaVersion":99,"catalogueVersion":1,"collections":[]}',
      ),
      throwsFormatException,
    );
  });

  test('pack catalogue rejects invalid hashes', () {
    const value = '''
      {"schemaVersion":1,"catalogueVersion":1,"collections":[
        {"id":"monthly-letters","slug":"monthly-letters","name":"Monthly Letters","description":"Archive","collectionType":"monthly_letters","displayOrder":1,"documentCount":1,"uniqueItemCount":1,"contentVersion":1,"downloadSize":100,"pack":{"url":"packs/monthly.zip","fileSize":100,"sha256":"invalid","version":1}}
      ]}
    ''';
    expect(() => ArchiveCatalogue.decode(value), throwsFormatException);
  });

  test('pack and collection versions must match', () {
    const hash =
        '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
    expect(
      () => ArchiveCatalogue.decode('''
        {"schemaVersion":1,"catalogueVersion":1,"collections":[
          {"id":"monthly-letters","slug":"monthly-letters","name":"Monthly Letters","description":"Archive","collectionType":"monthly_letters","displayOrder":1,"documentCount":1,"uniqueItemCount":1,"contentVersion":2,"downloadSize":100,"pack":{"url":"packs/monthly.zip","fileSize":100,"sha256":"$hash","version":1}}
        ]}
      '''),
      throwsFormatException,
    );
  });

  test('AMOLED mode uses a true black application background', () {
    final theme = buildAppTheme(Brightness.dark, palette: ReaderPalette.amoled);
    expect(theme.scaffoldBackgroundColor, Colors.black);
    expect(theme.colorScheme.surface, Colors.black);
  });

  test('Scroll PDFs are hidden from the reader capability surface', () {
    const document = ArchiveDocument(
      id: 'scroll-001',
      collectionId: 'prophetic-scrolls',
      slug: 'scroll-001',
      displayTitle: 'Scroll 1',
      documentType: 'scroll',
      sortOrder: 10,
      hasResponsiveText: true,
      hasCleanPdf: true,
      hasOriginalScan: false,
      contentVersion: 1,
      numberVerified: true,
      assets: <DocumentAsset>[],
    );
    expect(document.showsPdf, isFalse);
  });
}
