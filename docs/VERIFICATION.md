# V1 verification record

Verified on 2026-08-11 with Flutter 3.44.9, Dart 3.12.2, JDK 17,
Android SDK 36, and Visual Studio Build Tools 2022 17.14.

- `flutter doctor -v`: no issues.
- `flutter analyze`: no issues.
- `flutter test`: 22 tests passed, including onboarding, direct section navigation,
  type-ahead search, immediate collection filters, and in-reader highlight rendering.
- Authentic content catalogue/manifests: validated against the public content repository;
  a live download and FTS lookup resolved Translation Alert 001, Point 23.
- Worker TypeScript check: passed.
- Cloudflare Vitest runtime: 5 tests passed.
- Windows x64 release build: passed; cold-launch smoke test remained healthy.
- Android universal release APK: passed; installed and cold-launched on an API 36
  Google APIs x86_64 emulator.
- Android vertical slice: collection download, FTS Point 23 navigation,
  the exact block deep link opened, a bookmark was stored, and the bookmark was
  present after a cold restart.

Development artifact checksums:

- Android APK SHA-256: `9D80B890D4D6694F6E771063DF8056D48CA96367604F2874788DB5ADFA4D965E`
- Windows portable ZIP SHA-256: `0E3F730E31A1DD19B0638BD399B1CAE52356D0E0ACEC54D12A31E2D645C10F5F`

These are development artifacts, not publisher releases. Production remains
guarded until the remaining authentic documents/assets, final identities and
legal approval, AI service URL, and signing material are supplied.
