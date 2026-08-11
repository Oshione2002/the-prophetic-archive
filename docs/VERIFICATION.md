# V1 verification record

Verified on 2026-08-11 with Flutter 3.44.9, Dart 3.12.2, JDK 17,
Android SDK 36, and Visual Studio Build Tools 2022 17.14.

- `flutter doctor -v`: no issues.
- `flutter analyze`: no issues.
- `flutter test`: 46 tests passed, including onboarding, direct section navigation,
  type-ahead search, immediate collection filters, AMOLED theming, current content
  manifest compatibility, persistent highlights, synchronized TTS highlighting/jumps,
  Scripture reference parsing, additive index migration, offline occurrences, and the
  persistent non-modal KJV panel.
- Authentic content catalogue/manifests: validated against the public content repository;
  727 published documents passed validation (325 Scroll parts, 141 Special Writings,
  62 Translation Alerts, and 199 Monthly Letters).
- Worker TypeScript check: passed.
- Cloudflare Vitest runtime: 5 tests passed.
- Windows x64 release build: passed; cold-launch smoke test remained healthy.
- Android universal release APK: passed; installed and cold-launched on an API 36
  Google APIs x86_64 emulator.
- Android vertical slice: collection download, FTS Point 23 navigation,
  the exact block deep link opened, a bookmark was stored, and the bookmark was
  present after a cold restart.

Development artifact checksums:

- Android APK SHA-256: `D7B9DFCC0D9BA613C34862AA7039D361EAB20F7A17C2668BA70936019B03B448`
- Windows portable ZIP SHA-256: `912F933B8777498765C8A8A77E18124E93268CA0038353207379B08E29731634`

These are development artifacts, not publisher releases. Production remains
guarded until the remaining authentic documents/assets, final identities and
legal approval, AI service URL, and signing material are supplied.
