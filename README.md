# The Prophetic Archive

The Capstone Digital Library is an offline-first Flutter archive for Android and Windows. The application engine is deliberately separate from archive content: users install lightweight collection packs and independently choose PDFs or Original Scans.

Archive content is not copied into this repository. By default, the app reads the catalogue and authentic published documents from [Oshione2002/the-prophetic-archive-content](https://github.com/Oshione2002/the-prophetic-archive-content). The source repository can add the remaining documents and packaged PDF assets without requiring changes to the app.

## Development

Prerequisites: Flutter 3.44+, Dart 3.12+, JDK 17, Android SDK 36, and Visual Studio 2022 Desktop development with C++.

```powershell
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter run -d windows
```

Runtime configuration uses Dart defines:

```text
APP_ENV=development|production
ARCHIVE_CATALOGUE_URL=https://...
AI_BASE_URL=https://...
```

The authentic catalogue URL above is the default. Production rejects a missing/non-HTTPS override. DOCX masters, signing files, and private keys never belong here.

See [Architecture](docs/ARCHITECTURE.md), [Content Guide](docs/CONTENT_GUIDE.md), [Inline Scripture references](docs/SCRIPTURE_REFERENCES.md), [Building](docs/BUILDING.md), [Releasing](docs/RELEASING.md), [Security](docs/SECURITY.md), [Verification](docs/VERIFICATION.md), and [Third-party notices](docs/THIRD_PARTY_NOTICES.md).
