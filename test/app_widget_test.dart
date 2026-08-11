import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_prophetic_archive/app.dart';
import 'package:the_prophetic_archive/core/database/archive_database.dart';
import 'package:the_prophetic_archive/core/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('onboarding can be skipped into the adaptive application shell', (
    tester,
  ) async {
    final databases = DatabaseBundle(
      archive: ArchiveDatabase(NativeDatabase.memory()),
      app: AppDatabase(NativeDatabase.memory()),
    );
    addTearDown(databases.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseBundleProvider.overrideWithValue(databases)],
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
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
  });
}
