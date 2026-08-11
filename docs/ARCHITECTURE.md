# Architecture

## Boundaries

Flutter features depend on repository contracts, never SQL or provider SDKs. Riverpod supplies implementations; GoRouter owns stable internal routes.

`archive.sqlite` holds installed, replaceable archive content and FTS5. `app.sqlite` holds local catalogue state, downloads, settings, bookmarks, highlights, notes, and progress. Collection removal and content replacement cannot cascade into personal data.

## Content flow

Reviewed structured source → validator → per-collection SQLite/FTS pack → ZIP/checksum → static catalogue → validated transactional install → reader/search.

The app loads a cached catalogue immediately and may refresh it in the background. Pack versions, catalogue version, and app semantic version are independent.

## Providers

Catalogue, content hosting, file storage, PDF, TTS, and AI implementations sit behind interfaces. The first static host is GitHub Releases-compatible HTTPS; the first AI proxy is a Cloudflare Worker with Gemini behind `AIProvider`.

## Failure model

Downloads use temporary state and declared size/checksum validation. Unsupported schemas, corrupt packs, missing assets, and failed migrations leave the active content untouched. AI failure never disables local reading or search.
