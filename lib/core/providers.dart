import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'config/app_config.dart';
import 'database/archive_database.dart' hide DocumentBlock;
import 'domain/archive_models.dart';
import 'repositories/ai_repository.dart';
import 'repositories/archive_repository.dart';
import 'repositories/contracts.dart';
import 'repositories/tts_service.dart';
import 'theme/app_theme.dart';

final databaseBundleProvider = Provider<DatabaseBundle>(
  (ref) => throw StateError('DatabaseBundle must be overridden at startup.'),
);

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final archiveRepositoryProvider = Provider<ArchiveRepository>((ref) {
  return ArchiveRepository(
    ref.watch(databaseBundleProvider),
    ref.watch(appConfigProvider),
  );
});

final aiRepositoryProvider = Provider<AIRepository>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.hasAIEndpoint) return const UnavailableAIRepository();
  return RemoteAIRepository(
    baseUrl: config.aiBaseUrl,
    clientIdProvider: () async {
      final settings = ref.read(archiveRepositoryProvider);
      final existing = await settings.getValue('anonymous_client_id');
      if (existing != null) return existing;
      final created = const Uuid().v4();
      await settings.setValue('anonymous_client_id', created);
      return created;
    },
  );
});

final ttsServiceProvider = Provider<TextToSpeechService>(
  (ref) => DeviceTextToSpeechService(),
);

final catalogueProvider = FutureProvider<ArchiveCatalogue>(
  (ref) => ref.watch(archiveRepositoryProvider).loadCatalogue(),
);

final collectionsProvider = FutureProvider<List<CollectionSummary>>(
  (ref) => ref.watch(archiveRepositoryProvider).getCollections(),
);

final downloadStatesProvider = FutureProvider<Map<String, String>>(
  (ref) => ref.watch(archiveRepositoryProvider).getDownloadStates(),
);

final downloadJobsProvider = FutureProvider<Map<String, DownloadJob>>(
  (ref) => ref.watch(archiveRepositoryProvider).getDownloadJobs(),
);

final documentsProvider = FutureProvider.family<List<ArchiveDocument>, String>(
  (ref, collectionId) =>
      ref.watch(archiveRepositoryProvider).getDocuments(collectionId),
);

final documentProvider = FutureProvider.family<ArchiveDocument?, String>(
  (ref, id) => ref.watch(archiveRepositoryProvider).getDocument(id),
);

final blocksProvider = FutureProvider.family<List<DocumentBlock>, String>(
  (ref, documentId) =>
      ref.watch(archiveRepositoryProvider).getBlocks(documentId),
);

final bookmarksProvider = FutureProvider<List<BookmarkRecord>>(
  (ref) => ref.watch(archiveRepositoryProvider).getBookmarks(),
);

final notesProvider = FutureProvider<List<NoteRecord>>(
  (ref) => ref.watch(archiveRepositoryProvider).getNotes(),
);

final highlightsProvider = FutureProvider<List<HighlightRecord>>(
  (ref) => ref.watch(archiveRepositoryProvider).getHighlights(),
);

final readingHistoryProvider = FutureProvider<List<ReadingProgressRecord>>(
  (ref) => ref.watch(archiveRepositoryProvider).getReadingHistory(),
);

final topicsProvider = FutureProvider<List<String>>(
  (ref) => ref.watch(archiveRepositoryProvider).getTopics(),
);

final scriptureReferencesProvider =
    FutureProvider<List<ScriptureReferenceRecord>>(
      (ref) => ref.watch(archiveRepositoryProvider).getScriptureReferences(),
    );

final timelineProvider = FutureProvider<List<TimelineRecord>>(
  (ref) => ref.watch(archiveRepositoryProvider).getTimeline(),
);

final crossReferencesProvider =
    FutureProvider.family<List<CrossReferenceRecord>, String>(
      (ref, documentId) =>
          ref.watch(archiveRepositoryProvider).getCrossReferences(documentId),
    );

final storageSummaryProvider = FutureProvider<StorageSummary>(
  (ref) => ref.watch(archiveRepositoryProvider).getStorageSummary(),
);

final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  return await ref
          .watch(archiveRepositoryProvider)
          .getValue('onboarding_complete') ==
      'true';
});

final monthlyOldestFirstProvider = FutureProvider<bool>((ref) async {
  return await ref
          .watch(archiveRepositoryProvider)
          .getValue('monthly_oldest_first') ==
      'true';
});

class ReaderPreferences {
  const ReaderPreferences({
    this.palette = ReaderPalette.light,
    this.fontSize = 19,
    this.lineHeight = 1.65,
    this.maxWidth = 760,
  });

  final ReaderPalette palette;
  final double fontSize;
  final double lineHeight;
  final double maxWidth;

  ReaderPreferences copyWith({
    ReaderPalette? palette,
    double? fontSize,
    double? lineHeight,
    double? maxWidth,
  }) => ReaderPreferences(
    palette: palette ?? this.palette,
    fontSize: fontSize ?? this.fontSize,
    lineHeight: lineHeight ?? this.lineHeight,
    maxWidth: maxWidth ?? this.maxWidth,
  );
}

class ReaderPreferencesNotifier extends Notifier<ReaderPreferences> {
  @override
  ReaderPreferences build() {
    unawaited(_load());
    return const ReaderPreferences();
  }

  Future<void> _load() async {
    final settings = ref.read(archiveRepositoryProvider);
    final values = await Future.wait(<Future<String?>>[
      settings.getValue('reader_palette'),
      settings.getValue('reader_font_size'),
      settings.getValue('reader_line_height'),
      settings.getValue('reader_max_width'),
    ]);
    final palette = ReaderPalette.values.where(
      (item) => item.name == values[0],
    );
    state = ReaderPreferences(
      palette: palette.isEmpty ? state.palette : palette.first,
      fontSize: double.tryParse(values[1] ?? '') ?? state.fontSize,
      lineHeight: double.tryParse(values[2] ?? '') ?? state.lineHeight,
      maxWidth: double.tryParse(values[3] ?? '') ?? state.maxWidth,
    );
  }

  void update(ReaderPreferences value) {
    state = value;
    final settings = ref.read(archiveRepositoryProvider);
    unawaited(settings.setValue('reader_palette', value.palette.name));
    unawaited(settings.setValue('reader_font_size', value.fontSize.toString()));
    unawaited(
      settings.setValue('reader_line_height', value.lineHeight.toString()),
    );
    unawaited(settings.setValue('reader_max_width', value.maxWidth.toString()));
  }
}

final readerPreferencesProvider =
    NotifierProvider<ReaderPreferencesNotifier, ReaderPreferences>(
      ReaderPreferencesNotifier.new,
    );
