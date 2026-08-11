import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main(List<String> arguments) {
  final root = Directory.current.path;
  final sourceArgument = _argument(arguments, '--source');
  final catalogueArgument = _argument(arguments, '--catalogue');
  if (sourceArgument == null || catalogueArgument == null) {
    stderr.writeln(
      'Usage: dart run tool/content_pipeline/main.dart '
      '--source <content.json> --catalogue <catalogue.json> [--output <dir>] '
      '[--validate-only]',
    );
    exitCode = 64;
    return;
  }
  final sourcePath = p.normalize(p.absolute(sourceArgument));
  final cataloguePath = p.normalize(p.absolute(catalogueArgument));
  final outputPath =
      _argument(arguments, '--output') ?? p.join(root, 'build', 'content');
  final validateOnly = arguments.contains('--validate-only');

  final source =
      jsonDecode(File(sourcePath).readAsStringSync()) as Map<String, Object?>;
  final catalogue =
      jsonDecode(File(cataloguePath).readAsStringSync())
          as Map<String, Object?>;
  final report = validateContent(source, catalogue);
  for (final message in report.messages) {
    stdout.writeln('${message.level.toUpperCase()}: ${message.text}');
  }
  if (!report.valid) exitCode = 1;
  if (!report.valid || validateOnly) return;

  final output = Directory(outputPath)..createSync(recursive: true);
  final builtCatalogue = buildContentPacks(source, catalogue, output);
  File(p.join(output.path, 'catalogue.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(builtCatalogue),
  );
  File(p.join(output.path, 'validation-report.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(report.toJson()),
  );
  stdout.writeln('Built validated content packs in ${output.path}');
}

String? _argument(List<String> arguments, String name) {
  final index = arguments.indexOf(name);
  return index >= 0 && index + 1 < arguments.length
      ? arguments[index + 1]
      : null;
}

ValidationReport validateContent(
  Map<String, Object?> source,
  Map<String, Object?> catalogue,
) {
  final messages = <ValidationMessage>[];
  final developmentFixture = source['developmentFixture'] == true;
  if (source['schemaVersion'] != 1) {
    messages.add(
      const ValidationMessage('error', 'Unsupported content schema.'),
    );
  }
  if (catalogue['schemaVersion'] != 1) {
    messages.add(
      const ValidationMessage('error', 'Unsupported catalogue schema.'),
    );
  }
  final collectionIds = (catalogue['collections']! as List<Object?>)
      .cast<Map<String, Object?>>()
      .map((item) => item['id'])
      .whereType<String>()
      .toSet();
  if (collectionIds.contains('pages')) {
    messages.add(
      const ValidationMessage(
        'error',
        'Pages must not be a top-level collection.',
      ),
    );
  }
  final documents = (source['documents']! as List<Object?>)
      .cast<Map<String, Object?>>();
  final ids = <String>{};
  final assetIds = <String>{};
  for (final document in documents) {
    final id = document['id'] as String?;
    if (id == null || !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(id)) {
      messages.add(
        ValidationMessage('error', 'Invalid stable document id: $id'),
      );
      continue;
    }
    if (!ids.add(id)) {
      messages.add(ValidationMessage('error', 'Duplicate document id: $id'));
    }
    if (!collectionIds.contains(document['collectionId'])) {
      messages.add(
        ValidationMessage('error', '$id references an unknown collection.'),
      );
    }
    final slug = document['slug'] as String?;
    if (slug == null || !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(slug)) {
      messages.add(ValidationMessage('error', '$id has an invalid slug.'));
    }
    final publicationDate = document['publicationDate'] as String?;
    if (publicationDate != null && DateTime.tryParse(publicationDate) == null) {
      messages.add(
        ValidationMessage('error', '$id has an invalid publication date.'),
      );
    }
    final blocks = ((document['blocks'] as List<Object?>?) ?? const <Object?>[])
        .cast<Map<String, Object?>>();
    final blockIds = <String>{};
    for (var index = 0; index < blocks.length; index++) {
      final block = blocks[index];
      final blockId = block['id'] as String?;
      if (blockId == null ||
          !blockId.startsWith('$id:') ||
          !blockIds.add(blockId)) {
        messages.add(
          ValidationMessage(
            'error',
            '$id has an invalid or duplicate block id.',
          ),
        );
      }
      if (block['orderIndex'] != index + 1) {
        messages.add(
          ValidationMessage(
            'error',
            '$id block order must be contiguous from 1.',
          ),
        );
      }
      if (document['documentType'] == 'translation_alert' &&
          block['type'] == 'numbered_item' &&
          (block['numberLabel'] as String?)?.isEmpty != false) {
        messages.add(
          ValidationMessage(
            'error',
            '$id has a numbered item without a numberLabel.',
          ),
        );
      }
    }
    final assets = ((document['assets'] as List<Object?>?) ?? const <Object?>[])
        .cast<Map<String, Object?>>();
    final types = assets.map((asset) => asset['fileType']).toSet();
    if (document['hasCleanPdf'] == true && !types.contains('clean_pdf')) {
      messages.add(
        ValidationMessage('error', '$id claims a PDF but supplies no asset.'),
      );
    }
    if (document['hasOriginalScan'] == true &&
        !types.contains('original_scan')) {
      messages.add(
        ValidationMessage(
          'error',
          '$id claims an Original Scan but supplies no asset.',
        ),
      );
    }
    if (document['documentType'] == 'page' &&
        document['hasOriginalScan'] == true) {
      messages.add(
        ValidationMessage(
          'error',
          '$id is a Page and cannot claim an Original Scan.',
        ),
      );
    }
    if (document['partNumber'] != null && document['parentNumber'] == null) {
      messages.add(
        ValidationMessage(
          'error',
          '$id has a partNumber without parentNumber metadata.',
        ),
      );
    }
    for (final asset in assets) {
      final assetId = asset['id'] as String?;
      final fileType = asset['fileType'] as String?;
      final version = asset['version'];
      if (assetId == null ||
          !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(assetId) ||
          !assetIds.add(assetId)) {
        messages.add(
          ValidationMessage(
            'error',
            '$id has an invalid or duplicate asset id.',
          ),
        );
      }
      if (fileType == null ||
          !RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(fileType) ||
          version is! num ||
          version.toInt() < 1) {
        messages.add(
          ValidationMessage('error', '$id has invalid asset metadata.'),
        );
      }
      final assetPath = asset['assetPath'] as String?;
      if (assetPath != null && !File(assetPath).existsSync()) {
        messages.add(
          ValidationMessage('error', '$id is missing asset $assetPath.'),
        );
      }
      final remoteUrl = asset['remoteUrl'] as String?;
      if (!developmentFixture &&
          (remoteUrl == null ||
              !remoteUrl.startsWith('https://') ||
              asset['fileSize'] is! num ||
              (asset['fileSize']! as num).toInt() < 1 ||
              asset['sha256'] is! String ||
              !RegExp(
                r'^[a-fA-F0-9]{64}$',
              ).hasMatch(asset['sha256']! as String))) {
        messages.add(
          ValidationMessage(
            'error',
            '$id production assets require HTTPS, size, and SHA-256.',
          ),
        );
      }
      if (assetPath != null && File(assetPath).existsSync()) {
        final bytes = File(assetPath).readAsBytesSync();
        if (asset['fileSize'] is num &&
            (asset['fileSize']! as num).toInt() != bytes.length) {
          messages.add(
            ValidationMessage('error', '$id asset size does not match.'),
          );
        }
        if (asset['sha256'] is String &&
            (asset['sha256']! as String).toLowerCase() !=
                sha256.convert(bytes).toString()) {
          messages.add(
            ValidationMessage('error', '$id asset checksum does not match.'),
          );
        }
      }
    }
  }
  if (documents.any((document) => document['collectionId'] == 'pages')) {
    messages.add(
      const ValidationMessage(
        'error',
        'Page documents must belong to prophetic-scrolls.',
      ),
    );
  }
  final crossReferenceIds = <String>{};
  for (final document in documents) {
    final documentId = document['id'] as String?;
    final blockIds =
        ((document['blocks'] as List<Object?>?) ?? const <Object?>[])
            .cast<Map<String, Object?>>()
            .map((block) => block['id'])
            .whereType<String>()
            .toSet();
    for (final reference
        in ((document['crossReferences'] as List<Object?>?) ??
                const <Object?>[])
            .cast<Map<String, Object?>>()) {
      final referenceId = reference['id'] as String?;
      final sourceBlockId = reference['sourceBlockId'] as String?;
      if (referenceId == null ||
          !referenceId.startsWith('$documentId:') ||
          !crossReferenceIds.add(referenceId) ||
          !ids.contains(reference['targetDocumentId']) ||
          (sourceBlockId != null && !blockIds.contains(sourceBlockId)) ||
          reference['verified'] != true) {
        messages.add(
          ValidationMessage(
            'error',
            '$documentId has an invalid or unverified cross-reference.',
          ),
        );
      }
    }
  }
  final collections = (catalogue['collections']! as List<Object?>)
      .cast<Map<String, Object?>>();
  for (final collection in collections) {
    final collectionId = collection['id'] as String?;
    final actualCount = documents
        .where((document) => document['collectionId'] == collectionId)
        .length;
    if (collection['documentCount'] != actualCount) {
      messages.add(
        ValidationMessage(
          'error',
          '$collectionId declares ${collection['documentCount']} documents but supplies $actualCount.',
        ),
      );
    }
  }
  final multipartGroups = <String, List<int>>{};
  for (final document in documents.where(
    (item) => item['partNumber'] != null,
  )) {
    final key = '${document['collectionId']}:${document['parentNumber']}';
    multipartGroups
        .putIfAbsent(key, () => <int>[])
        .add((document['partNumber']! as num).toInt());
  }
  for (final entry in multipartGroups.entries) {
    entry.value.sort();
    for (var index = 0; index < entry.value.length; index++) {
      if (entry.value[index] != index + 1) {
        messages.add(
          ValidationMessage(
            'error',
            '${entry.key} multipart numbering must be contiguous from Part 1.',
          ),
        );
        break;
      }
    }
  }
  if (messages.every((message) => message.level != 'error')) {
    messages.add(
      ValidationMessage(
        'info',
        'Validated ${documents.length} ${developmentFixture ? 'development' : 'production'} documents.',
      ),
    );
  }
  return ValidationReport(messages);
}

Map<String, Object?> buildContentPacks(
  Map<String, Object?> source,
  Map<String, Object?> catalogue,
  Directory output,
) {
  final documents = (source['documents']! as List<Object?>)
      .cast<Map<String, Object?>>();
  final collections = (catalogue['collections']! as List<Object?>)
      .cast<Map<String, Object?>>();
  final builtCollections = <Map<String, Object?>>[];
  for (final collection in collections) {
    final collectionId = collection['id']! as String;
    final selected = documents
        .where((document) => document['collectionId'] == collectionId)
        .toList();
    final workDirectory = Directory(p.join(output.path, '.$collectionId'))
      ..createSync(recursive: true);
    final databaseFile = File(p.join(workDirectory.path, 'content.sqlite'));
    if (databaseFile.existsSync()) databaseFile.deleteSync();
    final database = sqlite3.open(databaseFile.path);
    try {
      _createPackSchema(database);
      database.execute('BEGIN IMMEDIATE');
      database
          .execute('INSERT INTO pack_metadata VALUES (?, ?, ?, ?)', <Object?>[
            1,
            collectionId,
            collection['contentVersion'],
            source['developmentFixture'] == true ? 1 : 0,
          ]);
      for (final document in selected) {
        database.execute(
          'INSERT INTO documents VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          <Object?>[
            document['id'],
            document['collectionId'],
            document['displayTitle'],
            document['documentType'],
            document['documentNumber'],
            document['parentNumber'],
            document['partNumber'],
            document['sortOrder'],
            document['hasResponsiveText'] == true ? 1 : 0,
            document['hasCleanPdf'] == true ? 1 : 0,
            document['hasOriginalScan'] == true ? 1 : 0,
            document['publicationDate'],
            document['year'],
            document['month'],
          ],
        );
        for (final block
            in (document['blocks']! as List<Object?>)
                .cast<Map<String, Object?>>()) {
          database.execute(
            'INSERT INTO document_blocks VALUES (?, ?, ?, ?, ?, ?, ?)',
            <Object?>[
              block['id'],
              document['id'],
              block['orderIndex'],
              block['type'],
              block['text'],
              block['numberLabel'],
              block['headingLevel'],
            ],
          );
          database.execute('INSERT INTO search_index VALUES (?, ?, ?, ?, ?)', <
            Object?
          >[
            document['id'],
            document['displayTitle'],
            block['id'],
            block['numberLabel'] == null ? '' : 'Point ${block['numberLabel']}',
            block['text'],
          ]);
        }
      }
      database.execute('COMMIT');
    } catch (_) {
      database.execute('ROLLBACK');
      rethrow;
    } finally {
      database.close();
    }
    final packJson = utf8.encode(
      jsonEncode(<String, Object?>{
        'schemaVersion': 1,
        'collectionId': collectionId,
        'contentVersion': collection['contentVersion'],
        'documentCount': selected.length,
      }),
    );
    final databaseBytes = databaseFile.readAsBytesSync();
    final contentJson = utf8.encode(
      jsonEncode(<String, Object?>{
        'schemaVersion': 1,
        'developmentFixture': source['developmentFixture'] == true,
        'documents': selected,
      }),
    );
    final archive = Archive()
      ..addFile(
        ArchiveFile('content.sqlite', databaseBytes.length, databaseBytes),
      )
      ..addFile(ArchiveFile('pack.json', packJson.length, packJson))
      ..addFile(ArchiveFile('content.json', contentJson.length, contentJson));
    final zipBytes = ZipEncoder().encode(archive);
    final fileName = '$collectionId-v${collection['contentVersion']}.tpa.zip';
    File(p.join(output.path, fileName)).writeAsBytesSync(zipBytes, flush: true);
    final manifest = <String, Object?>{
      'schemaVersion': 1,
      'collectionId': collectionId,
      'contentVersion': collection['contentVersion'],
      'documents': selected,
    };
    File(
      p.join(output.path, '$collectionId.json'),
    ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifest));
    builtCollections.add(<String, Object?>{
      ...collection,
      'pack': <String, Object?>{
        'url': fileName,
        'fileSize': zipBytes.length,
        'sha256': sha256.convert(zipBytes).toString(),
        'version': collection['contentVersion'],
      },
    });
    databaseFile.deleteSync();
    workDirectory.deleteSync();
  }
  return <String, Object?>{
    ...catalogue,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    'collections': builtCollections,
  };
}

void _createPackSchema(Database database) {
  database.execute('''
    CREATE TABLE pack_metadata(schema_version INTEGER, collection_id TEXT, content_version INTEGER, development_fixture INTEGER);
    CREATE TABLE documents(id TEXT PRIMARY KEY, collection_id TEXT, display_title TEXT, document_type TEXT, document_number INTEGER, parent_number INTEGER, part_number INTEGER, sort_order INTEGER, has_responsive_text INTEGER, has_clean_pdf INTEGER, has_original_scan INTEGER, publication_date TEXT, year INTEGER, month INTEGER);
    CREATE TABLE document_blocks(id TEXT PRIMARY KEY, document_id TEXT, order_index INTEGER, block_type TEXT, block_text TEXT, number_label TEXT, heading_level INTEGER);
    CREATE VIRTUAL TABLE search_index USING fts5(document_id UNINDEXED, document_title, block_id UNINDEXED, block_label, body, tokenize='unicode61 remove_diacritics 2');
  ''');
}

class ValidationReport {
  const ValidationReport(this.messages);
  final List<ValidationMessage> messages;
  bool get valid => messages.every((message) => message.level != 'error');
  Map<String, Object?> toJson() => <String, Object?>{
    'valid': valid,
    'messages': messages.map((message) => message.toJson()).toList(),
  };
}

class ValidationMessage {
  const ValidationMessage(this.level, this.text);
  final String level;
  final String text;
  Map<String, Object?> toJson() => <String, Object?>{
    'level': level,
    'text': text,
  };
}
