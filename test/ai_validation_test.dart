import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/core/repositories/ai_repository.dart';

void main() {
  test('AI citation validation accepts requested IDs and deduplicates', () {
    expect(
      validateAiCitationIds(
        <Object?>[
          <String, Object?>{'sourceId': 'scroll-001:block-001'},
          <String, Object?>{'sourceId': 'scroll-001:block-001'},
        ],
        <String>{'scroll-001:block-001'},
      ),
      <String>['scroll-001:block-001'],
    );
  });

  test('AI citation validation rejects fabricated IDs', () {
    expect(
      () => validateAiCitationIds(
        <Object?>[
          <String, Object?>{'sourceId': 'fabricated:block'},
        ],
        <String>{'scroll-001:block-001'},
      ),
      throwsFormatException,
    );
  });
}
