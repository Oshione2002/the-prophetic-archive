import 'dart:io';

void main() {
  final failures = <String>[];
  final catalogueUrl = Platform.environment['ARCHIVE_CATALOGUE_URL'] ?? '';
  final aiUrl = Platform.environment['AI_BASE_URL'] ?? '';
  final releaseTarget = Platform.environment['RELEASE_TARGET'] ?? 'all';
  if (!catalogueUrl.startsWith('https://')) {
    failures.add('ARCHIVE_CATALOGUE_URL must be HTTPS.');
  }
  if (!aiUrl.startsWith('https://')) {
    failures.add('AI_BASE_URL must be HTTPS.');
  }
  final android = File('android/app/build.gradle.kts').readAsStringSync();
  if (android.contains('dev.propheticarchive.app')) {
    failures.add('Replace the development Android namespace.');
  }
  final windows = File('windows/runner/Runner.rc').readAsStringSync();
  if (windows.contains('dev.propheticarchive')) {
    failures.add('Replace the development Windows publisher identity.');
  }
  if ((Platform.environment['LEGAL_NOTICE_CONFIRMED'] ?? '') != 'true') {
    failures.add('LEGAL_NOTICE_CONFIRMED must be true.');
  }
  if ((releaseTarget == 'android' || releaseTarget == 'all') &&
      (Platform.environment['ANDROID_KEYSTORE_BASE64'] ?? '').isEmpty) {
    failures.add('Android signing material is missing.');
  }
  if (failures.isNotEmpty) {
    for (final failure in failures) {
      stderr.writeln('RELEASE BLOCKED: $failure');
    }
    exitCode = 1;
  }
}
