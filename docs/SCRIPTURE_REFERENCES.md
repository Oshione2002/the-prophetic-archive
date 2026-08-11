# Inline Scripture references

Archive text is never rewritten. During collection installation, the application parses each responsive-text block and stores the exact printed span, UTF-16 offsets, canonical segments, confidence, parser version, and any reviewed override version in `archive.sqlite`. Verse-level occurrence rows are expanded for fast offline lookup; chapter-only references are stored separately and are not counted as direct verse occurrences.

The KJV is discovered from catalogue metadata (`collectionType: bible`, `translationCode: KJV`), not by collection ID. The Bible collection is excluded as an archive occurrence source. If it is not installed, reference links and archive occurrence lookup continue to work, while the persistent reader panel offers a KJV download. No online Bible API is used.

The alias registry and 66-book versification in `lib/core/scripture` are generated from the published KJV collection. To refresh the non-textual canon metadata:

```powershell
dart run tool/generate_bible_canon.dart <content-repo>/content/kjv-bible lib/core/scripture/bible_canon.g.dart
```

Ambiguous malformed forms such as `Zech. 5-11` remain non-clickable. A target can be supplied only through a versioned `ScriptureReferenceOverride` that identifies the document, block, unchanged raw text or offsets, canonical segments, and a verification note. Increment `scriptureParserVersion` when parsing behavior changes; the app then rebuilds the derived index without reinstalling content or touching personal study data.

The test-only variant corpus at `test/fixtures/scripture_reference_variants.json` is conspicuously labelled and is derived from the supplied specification because the requested authoritative corpus/report files were not present in the app workspace.
