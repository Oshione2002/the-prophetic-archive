import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/core/scripture/scripture_reference_parser.dart';

void main() {
  final parser = ScriptureReferenceParser();

  group('ScriptureReferenceParser', () {
    test('passes the specification-derived variant fixture', () async {
      final fixture =
          jsonDecode(
                await File(
                  'test/fixtures/scripture_reference_variants.json',
                ).readAsString(),
              )
              as Map<String, Object?>;
      for (final item
          in (fixture['cases']! as List<Object?>)
              .cast<Map<String, Object?>>()) {
        final raw = item['raw']! as String;
        final spans = parser.parse(raw).spans;
        expect(spans, isNotEmpty, reason: raw);
        expect(spans.single.canonicalReference, item['canonical'], reason: raw);
      }
      for (final raw
          in (fixture['ambiguous']! as List<Object?>).cast<String>()) {
        expect(
          parser.parse(raw).spans.single.isClickable,
          isFalse,
          reason: raw,
        );
      }
    });

    test('preserves raw text and UTF-16 offsets inside prose', () {
      const text = 'Before — according to Rev. 13:16-17 in the final age.';
      final span = parser.parse(text).spans.single;

      expect(span.rawText, 'Rev. 13:16-17');
      expect(text.substring(span.startOffset, span.endOffset), span.rawText);
      expect(span.canonicalReference, 'Revelation 13:16-17');
    });

    test('supports spacing and corpus OCR aliases', () {
      final cases = <String, String>{
        'Rev. 13: 16': 'Revelation 13:16',
        'Rey. 16:12 and 17': 'Revelation 16:12; Revelation 16:17',
        'Duet. 6:4': 'Deuteronomy 6:4',
        'Isiah 9:6': 'Isaiah 9:6',
        'Obediah 6-7': 'Obadiah 1:6-7',
        'Naum. 1:7': 'Nahum 1:7',
        'Zeck. 4:6': 'Zechariah 4:6',
        'Kev. 13:16': 'Revelation 13:16',
      };
      for (final entry in cases.entries) {
        final spans = parser.parse(entry.key).spans;
        expect(spans, isNotEmpty, reason: entry.key);
        expect(spans.single.canonicalReference, entry.value, reason: entry.key);
      }
    });

    test('supports Arabic, Roman, no-space, and ordinal numbered books', () {
      final cases = <String, String>{
        '1Corinthians 15:52': '1 Corinthians 15:52',
        'I Cor. 15:52': '1 Corinthians 15:52',
        'II Thess. 2:8': '2 Thessalonians 2:8',
        'Second Timothy 3:16': '2 Timothy 3:16',
        '1st Timothy 4:12': '1 Timothy 4:12',
        'III John 2': '3 John 1:2',
        '11 Peter 3:9': '2 Peter 3:9',
        'Il Kings 22:8': '2 Kings 22:8',
      };
      for (final entry in cases.entries) {
        expect(
          parser.parse(entry.key).spans.single.canonicalReference,
          entry.value,
        );
      }
    });

    test('keeps non-contiguous lists separate and expands mixed ranges', () {
      final span = parser.parse('Rev. 16:12, 14 and 17-18').spans.single;

      expect(span.segments.map((item) => item.verseStart), <int?>[12, 14, 17]);
      expect(span.segments.last.verseEnd, 18);
      expect(span.segments.expand((item) => item.verses), <int>[
        12,
        14,
        17,
        18,
      ]);
    });

    test('distinguishes chapter words, lists, and supported Psalm ranges', () {
      expect(
        parser
            .parse('James chap. 5')
            .spans
            .single
            .segments
            .single
            .isChapterOnly,
        isTrue,
      );
      expect(
        parser
            .parse('Rev. 17 and 18')
            .spans
            .single
            .segments
            .map((item) => item.chapter),
        <int>[17, 18],
      );
      expect(
        parser
            .parse('Daniel 2 and 7')
            .spans
            .single
            .segments
            .map((item) => item.chapter),
        <int>[2, 7],
      );
      expect(
        parser
            .parse('Psalms 95-96')
            .spans
            .single
            .segments
            .map((item) => item.chapter),
        <int>[95, 96],
      );
    });

    test('inherits contextual verse shorthand only from safe context', () {
      expect(parser.parse('(v. 11)').spans, isEmpty);
      const inherited = ScriptureParsingContext(
        bookId: 'jeremiah',
        chapter: 29,
      );
      final contextual = parser
          .parse('(v. 11) and then Vrs. 12-13', context: inherited)
          .spans;

      expect(contextual, hasLength(2));
      expect(
        contextual.first.confidence,
        ScriptureReferenceConfidence.contextual,
      );
      expect(contextual.first.canonicalReference, 'Jeremiah 29:11');
      expect(contextual.last.canonicalReference, 'Jeremiah 29:12-13');
    });

    test('rejects structurally impossible chapters and verses', () {
      expect(parser.parse('Mark 666:1').spans, isEmpty);
      expect(parser.parse('John 3:99').spans, isEmpty);
      expect(parser.parse('Jude 26').spans, isEmpty);
    });

    test('does not make ambiguous malformed hyphen forms clickable', () {
      for (final value in <String>[
        'Isa. 9-6',
        'Zech. 5-11',
        'Rev. 13-14',
        'Gen. 1-28',
        'Luke 21-11',
      ]) {
        final span = parser.parse(value).spans.single;
        expect(
          span.confidence,
          ScriptureReferenceConfidence.ambiguous,
          reason: value,
        );
        expect(span.isClickable, isFalse, reason: value);
      }
    });

    test(
      'applies a versioned verified override without changing visible text',
      () {
        const segment = ScriptureReferenceSegment(
          bookId: 'zechariah',
          bookName: 'Zechariah',
          chapter: 5,
          verseStart: 11,
        );
        final overridden =
            ScriptureReferenceParser(
                  overrides: const <ScriptureReferenceOverride>[
                    ScriptureReferenceOverride(
                      documentId: 'scroll-1',
                      blockId: 'scroll-1:block-1',
                      rawText: 'Zech. 5-11',
                      segments: <ScriptureReferenceSegment>[segment],
                      verificationNote: 'Checked against the printed source.',
                      overrideVersion: 2,
                    ),
                  ],
                )
                .parse(
                  'See Zech. 5-11.',
                  documentId: 'scroll-1',
                  blockId: 'scroll-1:block-1',
                )
                .spans
                .single;

        expect(overridden.rawText, 'Zech. 5-11');
        expect(overridden.canonicalReference, 'Zechariah 5:11');
        expect(overridden.confidence, ScriptureReferenceConfidence.override);
        expect(overridden.overrideVersion, 2);
      },
    );

    test('ignores ordinary numbers, dates, money, and prose', () {
      const text = r'The year 1967, point 23, $20, 12-14 people, and page 9.';
      expect(parser.parse(text).spans, isEmpty);
    });
  });
}
