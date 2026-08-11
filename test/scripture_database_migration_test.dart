import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:the_prophetic_archive/core/database/archive_database.dart';

void main() {
  test('v2 archive migrates additively and retains installed rows', () async {
    final directory = await Directory.systemTemp.createTemp(
      'archive-v2-migration-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final file = File(
      '${directory.path}${Platform.pathSeparator}archive.sqlite',
    );
    final legacy = sqlite.sqlite3.open(file.path);
    legacy.execute('''
      CREATE TABLE archive_collections (
        id TEXT NOT NULL PRIMARY KEY,
        slug TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        collection_type TEXT NOT NULL,
        display_order INTEGER NOT NULL,
        document_count INTEGER NOT NULL,
        unique_item_count INTEGER NOT NULL,
        content_version INTEGER NOT NULL,
        metadata_json TEXT NOT NULL DEFAULT '{}'
      );
      CREATE TABLE documents (
        id TEXT NOT NULL PRIMARY KEY,
        collection_id TEXT NOT NULL REFERENCES archive_collections(id) ON DELETE CASCADE
      );
      CREATE TABLE document_blocks (
        id TEXT NOT NULL PRIMARY KEY,
        document_id TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE
      );
      INSERT INTO archive_collections VALUES
        ('kept', 'kept', 'Kept collection', '', 'documents', 1, 0, 0, 1, '{}');
      PRAGMA user_version = 2;
    ''');
    legacy.close();

    final database = ArchiveDatabase(NativeDatabase(file));
    addTearDown(database.close);
    expect(
      await database
          .customSelect(
            "SELECT name FROM archive_collections WHERE id = 'kept'",
          )
          .getSingle()
          .then((row) => row.read<String>('name')),
      'Kept collection',
    );
    final tables = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table' "
          "AND name LIKE 'scripture_%' ORDER BY name",
        )
        .get();
    expect(
      tables.map((row) => row.read<String>('name')),
      containsAll(<String>[
        'scripture_reference_segments',
        'scripture_reference_spans',
        'scripture_verse_occurrences',
      ]),
    );
  });
}
