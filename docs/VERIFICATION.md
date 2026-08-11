# V1 verification record

Verified on 2026-08-11 with Flutter 3.44.9, Dart 3.12.2, JDK 17,
Android SDK 36, and Visual Studio Build Tools 2022 17.14.

- `flutter doctor -v`: no issues.
- `flutter analyze`: no issues.
- `flutter test`: 29 tests passed, including onboarding, direct section navigation,
  type-ahead search, immediate collection filters, AMOLED theming, current content
  manifest compatibility, persistent highlights, and synchronized TTS highlighting/jumps.
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

- Android APK SHA-256: `3EAC149F082AF15106F3D3D3911520B1ED627C3E7C4184EDF3C6B2BF43E89D32`
- Windows portable ZIP SHA-256: `6FDEB290275F5812894F612AC17235D6C01C242500B42F3C2F911F1A3546C23E`

These are development artifacts, not publisher releases. Production remains
guarded until the remaining authentic documents/assets, final identities and
legal approval, AI service URL, and signing material are supplied.
