import 'bible_canon.g.dart';

const scriptureParserVersion = 1;

enum ScriptureReferenceConfidence { high, contextual, override, ambiguous }

class ScriptureReferenceSegment {
  const ScriptureReferenceSegment({
    required this.bookId,
    required this.bookName,
    required this.chapter,
    this.verseStart,
    this.verseEnd,
  });

  final String bookId;
  final String bookName;
  final int chapter;
  final int? verseStart;
  final int? verseEnd;

  bool get isChapterOnly => verseStart == null;

  Iterable<int> get verses sync* {
    final start = verseStart;
    if (start == null) return;
    final end = verseEnd ?? start;
    for (var verse = start; verse <= end; verse++) {
      yield verse;
    }
  }

  String get canonicalReference {
    if (verseStart == null) return '$bookName $chapter';
    final suffix = verseEnd == null || verseEnd == verseStart
        ? '$verseStart'
        : '$verseStart-$verseEnd';
    return '$bookName $chapter:$suffix';
  }
}

class ScriptureReferenceSpan {
  const ScriptureReferenceSpan({
    required this.id,
    required this.rawText,
    required this.startOffset,
    required this.endOffset,
    required this.confidence,
    required this.segments,
    required this.parserVersion,
    this.overrideVersion,
  });

  final String id;
  final String rawText;
  final int startOffset;
  final int endOffset;
  final ScriptureReferenceConfidence confidence;
  final List<ScriptureReferenceSegment> segments;
  final int parserVersion;
  final int? overrideVersion;

  bool get isClickable =>
      confidence != ScriptureReferenceConfidence.ambiguous &&
      segments.isNotEmpty;

  String get canonicalReference =>
      segments.map((segment) => segment.canonicalReference).join('; ');
}

class ScriptureParsingContext {
  const ScriptureParsingContext({required this.bookId, required this.chapter});

  final String bookId;
  final int chapter;
}

class ScriptureParseResult {
  const ScriptureParseResult({required this.spans, this.trailingContext});

  final List<ScriptureReferenceSpan> spans;
  final ScriptureParsingContext? trailingContext;
}

class ScriptureReferenceOverride {
  const ScriptureReferenceOverride({
    required this.documentId,
    required this.blockId,
    required this.rawText,
    required this.segments,
    required this.verificationNote,
    required this.overrideVersion,
    this.startOffset,
    this.endOffset,
  });

  final String documentId;
  final String blockId;
  final String rawText;
  final int? startOffset;
  final int? endOffset;
  final List<ScriptureReferenceSegment> segments;
  final String verificationNote;
  final int overrideVersion;
}

/// Central, UI-independent parser for the printed reference forms used by the
/// archive. Ambiguous hyphen forms remain indexed as non-clickable spans until
/// a reviewed [ScriptureReferenceOverride] supplies their canonical target.
class ScriptureReferenceParser {
  ScriptureReferenceParser({
    this.overrides = const <ScriptureReferenceOverride>[],
  });

  final List<ScriptureReferenceOverride> overrides;

  static String bookNameFor(String bookId) =>
      generatedBibleBooks[bookId]?.name ?? bookId;

  static const _corpusAliases = <String, String>{
    'nums': 'numbers',
    'duet': 'deuteronomy',
    'nehm': 'nehemiah',
    'psm': 'psalms',
    'pro': 'proverbs',
    'eccles': 'ecclesiastes',
    'isiah': 'isaiah',
    'obah': 'obadiah',
    'obed': 'obadiah',
    'obediah': 'obadiah',
    'nam': 'nahum',
    'naum': 'nahum',
    'zach': 'zechariah',
    'zeck': 'zechariah',
    'rey': 'revelation',
    'kev': 'revelation',
    'chorn': 'chronicles',
    '1chorn': '1-chronicles',
    '2chorn': '2-chronicles',
  };

  static final Map<String, String> _aliases = _buildAliases();

  static Map<String, String> _buildAliases() {
    final result = <String, String>{...generatedBibleAliases};
    for (final entry in generatedBibleBooks.entries) {
      result[_normalise(entry.key)] = entry.key;
      result[_normalise(entry.value.name)] = entry.key;
    }
    result.addAll(_corpusAliases);
    for (final prefix in const <String>['st', 'saint']) {
      for (final gospel in const <String>['matthew', 'mark', 'luke', 'john']) {
        result['$prefix$gospel'] = gospel;
      }
    }
    return result;
  }

  static String _normalise(String value) =>
      value.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');

  ScriptureParseResult parse(
    String text, {
    String documentId = '',
    String blockId = '',
    ScriptureParsingContext? context,
  }) {
    final spans = <ScriptureReferenceSpan>[];
    for (final override in overrides.where(
      (item) => item.documentId == documentId && item.blockId == blockId,
    )) {
      final start = override.startOffset ?? text.indexOf(override.rawText);
      final end = override.endOffset ?? start + override.rawText.length;
      if (start < 0 ||
          end > text.length ||
          text.substring(start, end) != override.rawText) {
        continue;
      }
      spans.add(
        ScriptureReferenceSpan(
          id: _spanId(blockId, start, end),
          rawText: override.rawText,
          startOffset: start,
          endOffset: end,
          confidence: ScriptureReferenceConfidence.override,
          segments: override.segments,
          parserVersion: scriptureParserVersion,
          overrideVersion: override.overrideVersion,
        ),
      );
    }

    final explicitPattern = RegExp(
      r'([A-Za-z0-9.]+(?:\s+[A-Za-z0-9.]+){0,3}?)\s+'
      r'((?:(?:chap(?:ter)?|ch)\.?\s*)?\d+'
      r'(?:\s*(?::\s*|(?:verses|verse|vrs|vers|ver|vs|vr|v)\.?\s*)'
      r'\d+(?:\s*[-–—]\s*\d+)?(?:\s*(?:,|&|and)\s*\d+(?:\s*[-–—]\s*\d+)?)*)?'
      r'(?:\s*[-–—]\s*\d+)?(?:\s*(?:and|&)\s*\d+)?)',
      caseSensitive: false,
    );
    for (final match in explicitPattern.allMatches(text)) {
      final resolved = _resolveBookCandidate(match.group(1)!);
      if (resolved == null) continue;
      final start = match.start + resolved.startDelta;
      final end = match.end;
      if (_overlaps(spans, start, end)) continue;
      final raw = text.substring(start, end);
      final segments = _parseTail(resolved.bookId, match.group(2)!);
      if (segments == null) continue;
      final confidence = segments.isEmpty
          ? ScriptureReferenceConfidence.ambiguous
          : ScriptureReferenceConfidence.high;
      spans.add(
        ScriptureReferenceSpan(
          id: _spanId(blockId, start, end),
          rawText: raw,
          startOffset: start,
          endOffset: end,
          confidence: confidence,
          segments: segments,
          parserVersion: scriptureParserVersion,
        ),
      );
    }

    spans.sort((a, b) => a.startOffset.compareTo(b.startOffset));
    final contextualPattern = RegExp(
      r'\(?\b(?:verses|verse|vrs|vers|ver|vs|vr|v)\.?\s*'
      r'(\d+(?:\s*[-–—]\s*\d+)?(?:\s*(?:,|&|and)\s*\d+(?:\s*[-–—]\s*\d+)?)*)\)?',
      caseSensitive: false,
    );
    for (final match in contextualPattern.allMatches(text)) {
      if (_overlaps(spans, match.start, match.end)) continue;
      var inherited = context;
      for (final prior in spans.where(
        (item) => item.endOffset <= match.start,
      )) {
        if (!prior.isClickable || prior.segments.isEmpty) continue;
        final last = prior.segments.last;
        inherited = ScriptureParsingContext(
          bookId: last.bookId,
          chapter: last.chapter,
        );
      }
      if (inherited == null) continue;
      final segments = _verseSegments(
        inherited.bookId,
        inherited.chapter,
        match.group(1)!,
      );
      if (segments == null) continue;
      spans.add(
        ScriptureReferenceSpan(
          id: _spanId(blockId, match.start, match.end),
          rawText: match.group(0)!,
          startOffset: match.start,
          endOffset: match.end,
          confidence: ScriptureReferenceConfidence.contextual,
          segments: segments,
          parserVersion: scriptureParserVersion,
        ),
      );
    }
    spans.sort((a, b) => a.startOffset.compareTo(b.startOffset));

    ScriptureParsingContext? trailing = context;
    for (final span in spans) {
      if (!span.isClickable || span.segments.isEmpty) continue;
      final segment = span.segments.last;
      trailing = ScriptureParsingContext(
        bookId: segment.bookId,
        chapter: segment.chapter,
      );
    }
    return ScriptureParseResult(spans: spans, trailingContext: trailing);
  }

  ({String bookId, int startDelta})? _resolveBookCandidate(String candidate) {
    final tokens = RegExp(r'\S+').allMatches(candidate).toList();
    for (var first = 0; first < tokens.length; first++) {
      final raw = candidate.substring(tokens[first].start);
      var key = _normalise(raw);
      key = _normaliseNumberedBook(key);
      final direct = _aliases[key];
      if (direct != null) {
        return (bookId: direct, startDelta: tokens[first].start);
      }
      final corpus = _corpusAliases[key];
      if (corpus != null) {
        final numbered = first > 0
            ? _normalise(candidate.substring(tokens[first - 1].start))
            : '';
        final prefixed = _normaliseNumberedBook(numbered);
        final id = _aliases[prefixed];
        if (id != null) {
          return (bookId: id, startDelta: tokens[first - 1].start);
        }
        return (bookId: corpus, startDelta: tokens[first].start);
      }
    }
    return null;
  }

  static String _normaliseNumberedBook(String key) {
    final replacements = <String, String>{
      'third': '3',
      '3rd': '3',
      'iii': '3',
      'second': '2',
      '2nd': '2',
      'ii': '2',
      'il': '2',
      'it': '2',
      '11': '2',
      'first': '1',
      '1st': '1',
      'i': '1',
    };
    for (final entry in replacements.entries) {
      if (key.startsWith(entry.key) && key.length > entry.key.length) {
        final remainder = key.substring(entry.key.length);
        if (RegExp(
          r'^(sam|samuel|ki|kgs|kings|ch|chr|chorn|chronicles|co|cor|corinthians|th|thess|thessalonians|ti|tim|timothy|pe|pet|peter|jn|john)',
        ).hasMatch(remainder)) {
          return '${entry.value}$remainder';
        }
      }
    }
    return key;
  }

  List<ScriptureReferenceSegment>? _parseTail(String bookId, String value) {
    final tail = value.trim();
    final verseMatch = RegExp(
      r'^(\d+)\s*(?::\s*|(?:verses|verse|vrs|vers|ver|vs|vr|v)\.?\s*)'
      r'(.+)$',
      caseSensitive: false,
    ).firstMatch(tail);
    if (verseMatch != null) {
      final chapter = int.parse(verseMatch.group(1)!);
      return _verseSegments(bookId, chapter, verseMatch.group(2)!);
    }
    final chapterWord = RegExp(
      r'^(?:chap(?:ter)?|ch)\.?\s*(\d+)$',
      caseSensitive: false,
    ).firstMatch(tail);
    if (chapterWord != null) {
      final chapter = int.parse(chapterWord.group(1)!);
      return _validChapter(bookId, chapter)
          ? <ScriptureReferenceSegment>[_chapterSegment(bookId, chapter)]
          : null;
    }
    final single = RegExp(r'^(\d+)$').firstMatch(tail);
    if (single != null) {
      final number = int.parse(single.group(1)!);
      if (_isSingleChapter(bookId)) return _verseSegments(bookId, 1, '$number');
      return _validChapter(bookId, number)
          ? <ScriptureReferenceSegment>[_chapterSegment(bookId, number)]
          : null;
    }
    final chapterList = RegExp(
      r'^(\d+)\s*(?:and|&)\s*(\d+)$',
      caseSensitive: false,
    ).firstMatch(tail);
    if (chapterList != null) {
      final chapters = <int>[
        int.parse(chapterList.group(1)!),
        int.parse(chapterList.group(2)!),
      ];
      if (chapters.any((chapter) => !_validChapter(bookId, chapter))) {
        return null;
      }
      return chapters
          .map((chapter) => _chapterSegment(bookId, chapter))
          .toList();
    }
    final hyphen = RegExp(r'^(\d+)\s*[-–—]\s*(\d+)$').firstMatch(tail);
    if (hyphen != null) {
      final first = int.parse(hyphen.group(1)!);
      final last = int.parse(hyphen.group(2)!);
      if (_isSingleChapter(bookId)) {
        return _verseSegments(bookId, 1, '$first-$last');
      }
      if (bookId == 'psalms' && first <= last && _validChapter(bookId, last)) {
        return <ScriptureReferenceSegment>[
          for (var chapter = first; chapter <= last; chapter++)
            _chapterSegment(bookId, chapter),
        ];
      }
      return const <ScriptureReferenceSegment>[];
    }
    return null;
  }

  List<ScriptureReferenceSegment>? _verseSegments(
    String bookId,
    int chapter,
    String expression,
  ) {
    if (!_validChapter(bookId, chapter)) return null;
    final normalized = expression
        .replaceAll(RegExp(r'\s+(?:and)\s+', caseSensitive: false), ',')
        .replaceAll('&', ',');
    final parts = normalized.split(',');
    final result = <ScriptureReferenceSegment>[];
    for (final part in parts) {
      final match = RegExp(
        r'^\s*(\d+)(?:\s*[-–—]\s*(\d+))?\s*$',
      ).firstMatch(part);
      if (match == null) return null;
      final start = int.parse(match.group(1)!);
      final end = int.tryParse(match.group(2) ?? '') ?? start;
      if (start > end ||
          !_validVerse(bookId, chapter, start) ||
          !_validVerse(bookId, chapter, end)) {
        return null;
      }
      result.add(
        ScriptureReferenceSegment(
          bookId: bookId,
          bookName: generatedBibleBooks[bookId]!.name,
          chapter: chapter,
          verseStart: start,
          verseEnd: end == start ? null : end,
        ),
      );
    }
    return result;
  }

  ScriptureReferenceSegment _chapterSegment(String bookId, int chapter) =>
      ScriptureReferenceSegment(
        bookId: bookId,
        bookName: generatedBibleBooks[bookId]!.name,
        chapter: chapter,
      );

  bool _validChapter(String bookId, int chapter) {
    final book = generatedBibleBooks[bookId];
    return book != null && chapter >= 1 && chapter <= book.verses.length;
  }

  bool _validVerse(String bookId, int chapter, int verse) =>
      _validChapter(bookId, chapter) &&
      verse >= 1 &&
      verse <= generatedBibleBooks[bookId]!.verses[chapter - 1];

  bool _isSingleChapter(String bookId) =>
      generatedBibleBooks[bookId]?.verses.length == 1;

  static bool _overlaps(
    List<ScriptureReferenceSpan> spans,
    int start,
    int end,
  ) => spans.any((span) => start < span.endOffset && end > span.startOffset);

  static String _spanId(String blockId, int start, int end) =>
      '${blockId.isEmpty ? 'text' : blockId}:scripture:$start-$end:v$scriptureParserVersion';
}
