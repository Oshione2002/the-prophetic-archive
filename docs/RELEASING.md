# Releasing

Application releases use semantic `vX.Y.Z` tags. Content packs use independent integer catalogue/collection versions.

Before tagging, replace the development package identity, obtain publisher approval for the legal and attribution wording, configure the authentic catalogue and AI URLs, validate content, and configure Android signing secrets. The release workflow builds a signed universal APK and Windows x64 portable ZIP and attaches them to the GitHub release.

Required Android secrets: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, and `ANDROID_STORE_PASSWORD`. Backend secrets are configured in Cloudflare, not GitHub source.

Required repository variables: `ARCHIVE_CATALOGUE_URL`, `AI_BASE_URL`, and
`LEGAL_NOTICE_CONFIRMED=true`. The confirmation variable must only be enabled
after the publisher has approved the app's legal and attribution presentation.
