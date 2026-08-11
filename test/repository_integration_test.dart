import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/core/config/app_config.dart';
import 'package:the_prophetic_archive/core/database/archive_database.dart';
import 'package:the_prophetic_archive/core/repositories/archive_repository.dart';

void main() {
  late DatabaseBundle databases;
  late ArchiveRepository repository;
  late HttpServer server;
  late bool includeNewScroll;

  setUp(() async {
    includeNewScroll = false;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      final response = _responseFor(
        request.uri.path,
        includeNewScroll: includeNewScroll,
      );
      request.response
        ..statusCode = response == null ? HttpStatus.notFound : HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(
          jsonEncode(response ?? <String, Object?>{'error': 'not found'}),
        );
      await request.response.close();
    });
    databases = DatabaseBundle(
      archive: ArchiveDatabase(NativeDatabase.memory()),
      app: AppDatabase(NativeDatabase.memory()),
    );
    repository = ArchiveRepository(
      databases,
      AppConfig(
        environment: 'development',
        catalogueUrl:
            'http://${InternetAddress.loopbackIPv4.address}:${server.port}/catalogue.json',
        aiBaseUrl: '',
      ),
    );
  });

  tearDown(() async {
    await databases.close();
    await server.close(force: true);
  });

  test('published content supports FTS Point 23 deep links', () async {
    await repository.downloadCollection('translation-alerts');
    final documents = await repository.getDocuments('translation-alerts');
    expect(documents.single.displayTitle, '001 — THE QUALIFICATIONS');

    final hits = await repository.search('prophecy');
    expect(hits, hasLength(1));
    expect(hits.single.blockLabel, 'Point 23');
    expect(hits.single.blockId, 'translation-alert-001:point-023');
  });

  test('published multipart Scrolls share one grouping number', () async {
    await repository.downloadCollection('prophetic-scrolls');
    final documents = await repository.getDocuments('prophetic-scrolls');
    expect(documents.first.displayTitle, 'Scroll 1');
    expect(documents.where((item) => item.parentNumber == 320), hasLength(2));
    expect(documents.every((item) => item.hasOriginalScan == false), isTrue);
  });

  test('content update discovers newly published repository files', () async {
    await repository.downloadCollection('prophetic-scrolls');
    expect(await repository.getDocuments('prophetic-scrolls'), hasLength(3));

    includeNewScroll = true;
    expect(await repository.updateDownloadedCollections(), 1);
    final documents = await repository.getDocuments('prophetic-scrolls');
    expect(documents, hasLength(4));
    expect(documents.any((item) => item.id == 'scroll-002'), isTrue);
  });

  test('content reinstall preserves and verifies highlight anchors', () async {
    await repository.downloadCollection('prophetic-scrolls');
    final block = (await repository.getBlocks('scroll-001')).single;
    final start = block.text.indexOf('Atomic');
    await repository.addHighlight(
      documentId: block.documentId,
      blockId: block.id,
      startOffset: start,
      endOffset: start + 'Atomic'.length,
      selectedText: 'Atomic',
    );

    await repository.downloadCollection('prophetic-scrolls');
    final highlight = (await repository.getHighlights()).single;
    expect(highlight.startOffset, start);
    expect(highlight.endOffset, start + 'Atomic'.length);
  });

  test('removing content retains personal study data', () async {
    await repository.downloadCollection('prophetic-scrolls');
    final document = (await repository.getDocuments('prophetic-scrolls')).first;
    await repository.toggleBookmark(document);
    await repository.addNote(document, 'Private test note');
    await repository.saveProgress(
      document,
      blockId: 'scroll-001:p001',
      percentage: 0.4,
    );

    await repository.removeCollection('prophetic-scrolls');
    expect(await repository.getDocuments('prophetic-scrolls'), isEmpty);
    expect(await repository.getBookmarks(), hasLength(1));
    expect(await repository.getNotes(), hasLength(1));
    expect(await repository.getReadingHistory(), hasLength(1));
  });

  test('personal-data deletion leaves downloaded content installed', () async {
    await repository.downloadCollection('translation-alerts');
    final document = (await repository.getDocuments(
      'translation-alerts',
    )).single;
    await repository.toggleBookmark(document);
    await repository.addNote(document, 'Delete me');

    await repository.deletePersonalStudyData();
    expect(await repository.getBookmarks(), isEmpty);
    expect(await repository.getNotes(), isEmpty);
    expect(await repository.getDocuments('translation-alerts'), hasLength(1));
  });
}

Object? _responseFor(
  String path, {
  required bool includeNewScroll,
}) => switch (path) {
  '/catalogue.json' => <String, Object?>{
    'schemaVersion': 1,
    'collections': <Object?>[
      <String, Object?>{
        'id': 'prophetic-scrolls',
        'name': 'Prophetic Scrolls',
        'uniqueScrollCount': 320,
        'documentParts': 325,
        'manifest': 'manifests/prophetic-scrolls.json',
      },
      <String, Object?>{
        'id': 'translation-alerts',
        'name': 'Translation Alerts',
        'alertCount': 61,
        'manifest': 'manifests/translation-alerts.json',
      },
    ],
  },
  '/manifests/prophetic-scrolls.json' => <String, Object?>{
    'id': 'prophetic-scrolls',
    'name': 'Prophetic Scrolls',
    'documents': <Object?>[
      <String, Object?>{'id': 'scroll-001', 'json': 'scroll-001.json'},
      if (includeNewScroll)
        <String, Object?>{'id': 'scroll-002', 'json': 'scroll-002.json'},
      <String, Object?>{
        'id': 'scroll-320-part-1',
        'json': 'scroll-320-part-1.json',
      },
      <String, Object?>{
        'id': 'scroll-320-part-2',
        'json': 'scroll-320-part-2.json',
      },
    ],
  },
  '/manifests/translation-alerts.json' => <String, Object?>{
    'schemaVersion': 1,
    'id': 'translation-alerts',
    'documents': <String>[
      'content/translation-alerts/translation-alert-001.json',
    ],
  },
  '/content/prophetic-scrolls/scroll-001.json' => _scroll(1),
  '/content/prophetic-scrolls/scroll-002.json' => _scroll(2),
  '/content/prophetic-scrolls/scroll-320-part-1.json' => _scroll(320, part: 1),
  '/content/prophetic-scrolls/scroll-320-part-2.json' => _scroll(320, part: 2),
  '/content/translation-alerts/translation-alert-001.json' => <String, Object?>{
    'id': 'translation-alert-001',
    'collection': 'translation-alerts',
    'number': 1,
    'title': 'THE QUALIFICATIONS',
    'date_raw': 'August 18, 1999 AM',
    'blocks': <Object?>[
      <String, Object?>{
        'id': 'p001',
        'type': 'paragraph',
        'text': 'The Qualifications:',
      },
      <String, Object?>{
        'id': 'point-023',
        'type': 'numbered_item',
        'number': 23,
        'numberLabel': '23',
        'text': 'Prophecy gives guidance and prophetic timing.',
      },
    ],
  },
  _ => null,
};

Map<String, Object?> _scroll(int number, {int? part}) {
  final suffix = part == null ? '' : '-part-$part';
  return <String, Object?>{
    'id': 'scroll-${number.toString().padLeft(3, '0')}$suffix',
    'collection': 'prophetic-scrolls',
    'document_type': 'scroll',
    'scroll_number': number,
    'part': part,
    'blocks': <Object?>[
      <String, Object?>{
        'id': 'p001',
        'type': 'paragraph',
        'text': 'Atomic history and archive text for Scroll $number.',
      },
    ],
  };
}
