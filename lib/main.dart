import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/database/archive_database.dart';
import 'core/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databases = await DatabaseBundle.open();
  runApp(
    ProviderScope(
      overrides: [databaseBundleProvider.overrideWithValue(databases)],
      child: const PropheticArchiveApp(),
    ),
  );
}
