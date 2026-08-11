# Dynamic collections

The app treats the configured HTTPS catalogue as the source of truth. Collection
IDs, names, order, counts, capabilities, covers, versions, manifests, documents,
and assets are data. Adding a collection to the content repository does not
require a Flutter release.

## Catalogue lifecycle

At startup the last valid cached catalogue is rendered immediately. The app then
performs one non-blocking conditional refresh. The Library sync button always
forces a refresh, discovers new collection IDs, and marks installed collections
whose `contentVersion` increased as `update_available`. The user explicitly
starts the collection download/update; the old installed version remains usable
until the replacement validates and commits.

The catalogue accepts the original archive fields as well as these generic
fields:

- `collectionType`, `description`, `displayOrder`, `contentVersion`, and
  `downloadSize`
- `icon`, `cover`, `thumbnail`, `translationCode`, and `sortMode`
- `capabilities`: `responsiveText`, `cleanPdf`, `originalScan`, `audio`,
  `video`, `bibleReader`, `verseNavigation`, and `search`
- any additional metadata, retained in `metadataJson`

Unknown collection and asset types remain string-backed. Titles are display
text, never identifiers.

## Generic documents and assets

Published documents use stable kebab-case IDs and ordered blocks. Generic
fields support `displayTitle`, `documentType`, `sortOrder`, `metadata`, and an
`assets` array. Assets can be PDFs, images, audio, or future file types and can
include `durationSeconds`, title/track metadata, declared size, version, and
SHA-256. Files are downloaded separately and a matching downloaded asset is
preserved across a content reinstall.

Audio is played offline from verified local files. Position is persisted per
asset. The player exposes play/pause, seeking, previous/next track, elapsed and
duration display, plus 0.5x, 1.0x, 1.5x, and 2.0x speeds.

## Bible collections

Set `collectionType` to `bible` or enable `capabilities.bibleReader`. Each
document represents one chapter and supplies this metadata:

```json
{
  "translationCode": "CODE",
  "bookId": "john",
  "bookName": "John",
  "bookOrder": 43,
  "testament": "New Testament",
  "chapter": 3
}
```

Blocks use `verse` or a numeric `numberLabel`. The installer creates normalized
verse records for book/chapter/verse navigation, offline search, reference deep
links, bookmarks, highlights, notes, copy, and local TTS. The application does
not fabricate Bible text; translations must be supplied by the content owner.

## Compatibility rules

The four original archive collections keep their existing Scroll, Page,
multipart, Translation Alert, Special Writing, and Monthly Letter behavior.
Older catalogues without the generic fields receive safe defaults. Database
migrations add fields and tables without deleting personal study data.

Before publishing, run:

```text
dart run tool/content_pipeline/main.dart --validate-only
```

With no local source arguments this validates the configured authentic GitHub
content repository. Local fixture pack generation still requires explicit
`--source` and `--catalogue` paths.
