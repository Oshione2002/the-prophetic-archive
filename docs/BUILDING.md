# Building

1. Install Flutter 3.44.9 stable, JDK 17, Android SDK 36, NuGet CLI, and Visual Studio 2022 Build Tools with MSVC v142, CMake tools, and Windows 10 SDK.
2. Run `flutter doctor -v`; Android and Windows toolchains must be green.
3. Run `flutter pub get` and `dart run build_runner build`.
4. Run `flutter analyze`, `flutter test`, `flutter build apk --release`, and `flutter build windows --release`.

The app uses the authentic public content repository by default. A different catalogue may be supplied with `ARCHIVE_CATALOGUE_URL`; production overrides must use HTTPS. Production releases must also use the final native package identity.

The pack-building CLI remains available for validated publisher inputs:

```powershell
dart run tool/content_pipeline/main.dart --source C:\path\content.json --catalogue C:\path\catalogue.json --validate-only
```
