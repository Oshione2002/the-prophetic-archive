import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/core/config/app_config.dart';
import 'package:the_prophetic_archive/core/database/archive_database.dart';
import 'package:the_prophetic_archive/core/domain/archive_models.dart';
import 'package:the_prophetic_archive/core/providers.dart';
import 'package:the_prophetic_archive/core/repositories/archive_repository.dart';
import 'package:the_prophetic_archive/features/explore/explore_screen.dart';
import 'package:the_prophetic_archive/features/reader/reader_screen.dart';
import 'package:the_prophetic_archive/features/search/search_screen.dart';
import 'package:the_prophetic_archive/features/study/study_screen.dart';

void main() {
  testWidgets('Explore honors direct topic destination', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scriptureReferencesProvider.overrideWith((ref) async => []),
          topicsProvider.overrideWith((ref) async => []),
          timelineProvider.overrideWith((ref) async => []),
        ],
        child: const MaterialApp(home: ExploreScreen(section: 'topics')),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      DefaultTabController.of(tester.element(find.byType(TabBar))).index,
      1,
    );
  });

  testWidgets('Study honors direct bookmark destination', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          bookmarksProvider.overrideWith((ref) async => []),
          highlightsProvider.overrideWith((ref) async => []),
          notesProvider.overrideWith((ref) async => []),
          readingHistoryProvider.overrideWith((ref) async => []),
        ],
        child: const MaterialApp(home: StudyScreen(section: 'bookmarks')),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      DefaultTabController.of(tester.element(find.byType(TabBar))).index,
      0,
    );
  });

  testWidgets('Search exposes Ask the Library in its app bar', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [collectionsProvider.overrideWith((ref) async => [])],
        child: const MaterialApp(home: SearchScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byTooltip('Ask the Library'), findsOneWidget);
  });

  testWidgets(
    'Search updates while typing and collection filters immediately',
    (tester) async {
      final databases = DatabaseBundle(
        archive: ArchiveDatabase(NativeDatabase.memory()),
        app: AppDatabase(NativeDatabase.memory()),
      );
      addTearDown(databases.close);
      final repository = _RecordingSearchRepository(databases);
      const collection = CollectionSummary(
        id: 'prophetic-scrolls',
        slug: 'prophetic-scrolls',
        name: 'Prophetic Scrolls',
        description: 'Archive',
        collectionType: 'prophetic_scrolls',
        displayOrder: 1,
        documentCount: 325,
        uniqueItemCount: 320,
        contentVersion: 1,
        downloadSize: 0,
        manifestPath: 'manifests/prophetic-scrolls.json',
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            archiveRepositoryProvider.overrideWithValue(repository),
            collectionsProvider.overrideWith((ref) async => [collection]),
          ],
          child: const MaterialApp(home: SearchScreen()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'prophecy');
      await tester.pump(const Duration(milliseconds: 160));
      expect(repository.calls, 1);

      await tester.tap(find.text('Prophetic Scrolls'));
      await tester.pumpAndSettle();
      expect(repository.calls, 2);
      expect(repository.lastCollectionId, 'prophetic-scrolls');
    },
  );

  testWidgets('saved highlight is rendered inside reader text', (tester) async {
    final databases = DatabaseBundle(
      archive: ArchiveDatabase(NativeDatabase.memory()),
      app: AppDatabase(NativeDatabase.memory()),
    );
    addTearDown(databases.close);
    await databases.archive.customStatement(
      'INSERT INTO archive_collections '
      '(id, slug, name, description, collection_type, display_order, '
      'document_count, unique_item_count, content_version) '
      "VALUES ('prophetic-scrolls', 'prophetic-scrolls', 'Prophetic Scrolls', "
      "'Archive', 'prophetic_scrolls', 1, 1, 320, 1)",
    );
    await databases.archive.customStatement(
      'INSERT INTO documents '
      '(id, collection_id, slug, display_title, document_type, sort_order, '
      'has_responsive_text, has_clean_pdf, has_original_scan, content_version, '
      'number_verified) '
      "VALUES ('scroll-001', 'prophetic-scrolls', 'scroll-001', 'Scroll 1', "
      "'scroll', 10, 1, 0, 0, 1, 1)",
    );
    await databases.archive.customStatement(
      'INSERT INTO document_blocks '
      '(id, document_id, order_index, block_type, block_text) '
      "VALUES ('scroll-001:p001', 'scroll-001', 1, 'paragraph', "
      "'Atomic archive text')",
    );
    final now = DateTime.now().toUtc().toIso8601String();
    await databases.app.customStatement(
      'INSERT INTO highlights '
      '(id, document_id, block_id, start_offset, end_offset, selected_text, '
      'style, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
      <Object?>[
        'highlight-1',
        'scroll-001',
        'scroll-001:p001',
        0,
        6,
        'Atomic',
        'gold',
        now,
        now,
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseBundleProvider.overrideWithValue(databases)],
        child: const MaterialApp(home: ReaderScreen(documentId: 'scroll-001')),
      ),
    );
    await tester.pumpAndSettle();

    final selectable = tester.widget<SelectableText>(
      find.byType(SelectableText),
    );
    final highlighted = selectable.textSpan!.children!
        .whereType<TextSpan>()
        .where((span) => span.style?.backgroundColor != null)
        .map((span) => span.text)
        .toList();
    expect(highlighted, contains('Atomic'));
  });
}

class _RecordingSearchRepository extends ArchiveRepository {
  _RecordingSearchRepository(DatabaseBundle databases)
    : super(
        databases,
        const AppConfig(
          environment: 'development',
          catalogueUrl: AppConfig.authenticCatalogueUrl,
          aiBaseUrl: '',
        ),
      );

  int calls = 0;
  String? lastCollectionId;

  @override
  Future<List<SearchHit>> search(
    String query, {
    String? collectionId,
    int limit = 50,
  }) async {
    calls++;
    lastCollectionId = collectionId;
    return const <SearchHit>[];
  }
}
