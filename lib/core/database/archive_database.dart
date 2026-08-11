import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'archive_database.g.dart';

@DriftDatabase(include: <String>{'archive.drift'})
class ArchiveDatabase extends _$ArchiveDatabase {
  ArchiveDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      final result = await customSelect(
        "SELECT sqlite_compileoption_used('ENABLE_FTS5') AS enabled",
      ).getSingle();
      if (result.read<int>('enabled') != 1) {
        throw StateError('The bundled SQLite library does not support FTS5.');
      }
    },
  );
}

@DriftDatabase(include: <String>{'app.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );
}

class DatabaseBundle {
  const DatabaseBundle({required this.archive, required this.app});

  final ArchiveDatabase archive;
  final AppDatabase app;

  static Future<DatabaseBundle> open() async {
    final support = await getApplicationSupportDirectory();
    final databaseDirectory = Directory(p.join(support.path, 'databases'));
    await databaseDirectory.create(recursive: true);
    final archive = ArchiveDatabase(
      NativeDatabase.createInBackground(
        File(p.join(databaseDirectory.path, 'archive.sqlite')),
      ),
    );
    final app = AppDatabase(
      NativeDatabase.createInBackground(
        File(p.join(databaseDirectory.path, 'app.sqlite')),
      ),
    );
    await archive.customSelect('SELECT 1').getSingle();
    await app.customSelect('SELECT 1').getSingle();
    return DatabaseBundle(archive: archive, app: app);
  }

  Future<void> close() async {
    await archive.close();
    await app.close();
  }
}
