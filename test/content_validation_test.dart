import 'package:flutter_test/flutter_test.dart';

import '../tool/content_pipeline/main.dart';

void main() {
  Map<String, Object?> catalogue({int documentCount = 1}) => <String, Object?>{
    'schemaVersion': 1,
    'developmentFixture': true,
    'collections': <Object?>[
      <String, Object?>{
        'id': 'monthly-letters',
        'documentCount': documentCount,
      },
    ],
  };

  Map<String, Object?> document({
    String id = 'monthly-letter-2005-06',
    int? partNumber,
    int? parentNumber,
  }) => <String, Object?>{
    'id': id,
    'slug': id,
    'collectionId': 'monthly-letters',
    'documentType': 'monthly_letter',
    'publicationDate': '2005-06-01',
    'partNumber': partNumber,
    'parentNumber': parentNumber,
    'hasCleanPdf': false,
    'hasOriginalScan': false,
    'blocks': <Object?>[
      <String, Object?>{
        'id': '$id:block-001',
        'orderIndex': 1,
        'type': 'paragraph',
        'text': 'Test archive paragraph.',
      },
    ],
  };

  test('content validation accepts stable representative content', () {
    final report = validateContent(<String, Object?>{
      'schemaVersion': 1,
      'developmentFixture': true,
      'documents': <Object?>[document()],
    }, catalogue());
    expect(report.valid, isTrue);
  });

  test('content validation rejects duplicate document IDs', () {
    final report = validateContent(<String, Object?>{
      'schemaVersion': 1,
      'developmentFixture': true,
      'documents': <Object?>[document(), document()],
    }, catalogue(documentCount: 2));
    expect(report.valid, isFalse);
    expect(
      report.messages.any((message) => message.text.contains('Duplicate')),
      isTrue,
    );
  });

  test('content validation rejects broken multipart numbering', () {
    final report = validateContent(<String, Object?>{
      'schemaVersion': 1,
      'developmentFixture': true,
      'documents': <Object?>[
        document(id: 'monthly-letter-part-2', partNumber: 2, parentNumber: 1),
      ],
    }, catalogue());
    expect(report.valid, isFalse);
    expect(
      report.messages.any((message) => message.text.contains('contiguous')),
      isTrue,
    );
  });
}
