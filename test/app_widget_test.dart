import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/app.dart';
import 'package:the_prophetic_archive/core/database/archive_database.dart';
import 'package:the_prophetic_archive/core/domain/archive_models.dart';
import 'package:the_prophetic_archive/core/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('onboarding can be skipped into the adaptive application shell', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final databases = DatabaseBundle(
      archive: ArchiveDatabase(NativeDatabase.memory()),
      app: AppDatabase(NativeDatabase.memory()),
    );
    addTearDown(databases.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseBundleProvider.overrideWithValue(databases),
          collectionsProvider.overrideWith(
            (ref) async => List<CollectionSummary>.generate(
              5,
              (index) => CollectionSummary(
                id: 'collection-${index + 1}',
                slug: 'collection-${index + 1}',
                name: 'Collection ${index + 1}',
                description: 'Archive collection',
                collectionType: 'documents',
                displayOrder: index + 1,
                documentCount: 1,
                uniqueItemCount: 1,
                contentVersion: 1,
                downloadSize: 0,
                manifestPath: 'manifests/collection-${index + 1}.json',
              ),
            ),
          ),
        ],
        child: const PropheticArchiveApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('The Prophetic Archive'), findsOneWidget);
    expect(find.text('Download selected'), findsOneWidget);
    expect(find.text('Skip for now'), findsOneWidget);

    await tester.tap(find.text('Skip for now'));
    await tester.pumpAndSettle();

    expect(find.text('Continue Reading'), findsOneWidget);
    expect(find.text('Collection 4'), findsOneWidget);
    expect(find.text('Collection 5'), findsNothing);
    expect(find.byTooltip('View all collections'), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.byTooltip('Collapse navigation'), findsOneWidget);
    await tester.tap(find.byTooltip('Collapse navigation'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Expand navigation'), findsOneWidget);
  });
}
