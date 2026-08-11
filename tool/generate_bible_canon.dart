import 'dart:convert';
import 'dart:io';

/// Regenerates the application's non-textual KJV versification metadata from
/// the published content repository. The generated file is committed so the
/// archive can validate references before the optional KJV collection is
/// downloaded.
Future<void> main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln(
      'Usage: dart run tool/generate_bible_canon.dart <kjv-content-dir> <output.dart>',
    );
    exitCode = 64;
    return;
  }
  final source = Directory(arguments[0]);
  final output = File(arguments[1]);
  final aliasJson =
      jsonDecode(
            await File(
              '${source.path}${Platform.pathSeparator}reference-aliases.json',
            ).readAsString(),
          )
          as Map<String, Object?>;
  final aliases = (aliasJson['aliases']! as Map<String, Object?>).map(
    (key, value) => MapEntry(key, value! as String),
  );
  final chapterFiles =
      await Directory('${source.path}${Platform.pathSeparator}chapters')
          .list(recursive: true)
          .where((item) => item is File && item.path.endsWith('.json'))
          .cast<File>()
          .toList();
  final books = <String, ({String name, int order, List<int> verses})>{};
  for (final file in chapterFiles) {
    final json = jsonDecode(await file.readAsString()) as Map<String, Object?>;
    final bookId = json['bookId']! as String;
    final chapter = (json['chapter']! as num).toInt();
    final count = (json['verseCount']! as num).toInt();
    final prior = books[bookId];
    final counts = prior?.verses ?? <int>[];
    while (counts.length < chapter) {
      counts.add(0);
    }
    counts[chapter - 1] = count;
    books[bookId] = (
      name: json['bookName']! as String,
      order: (json['bookOrder']! as num).toInt(),
      verses: counts,
    );
  }
  final ordered = books.entries.toList()
    ..sort((a, b) => a.value.order.compareTo(b.value.order));
  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT EDIT BY HAND.')
    ..writeln('// Source: the-prophetic-archive-content/content/kjv-bible.')
    ..writeln()
    ..writeln(
      'const generatedBibleBooks = <String, ({String name, int order, List<int> verses})>{',
    );
  for (final entry in ordered) {
    buffer.writeln(
      "  '${entry.key}': (name: ${jsonEncode(entry.value.name)}, order: ${entry.value.order}, verses: <int>${entry.value.verses}),",
    );
  }
  buffer
    ..writeln('};')
    ..writeln()
    ..writeln('const generatedBibleAliases = <String, String>{');
  final aliasEntries = aliases.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  for (final entry in aliasEntries) {
    buffer.writeln("  '${entry.key}': '${entry.value}',");
  }
  buffer.writeln('};');
  await output.parent.create(recursive: true);
  await output.writeAsString(buffer.toString());
}
