import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/providers.dart';
import 'core/theme/app_theme.dart';
import 'features/ai/ask_library_screen.dart';
import 'features/bible/bible_screen.dart';
import 'features/explore/explore_screen.dart';
import 'features/home/home_screen.dart';
import 'features/library/collection_screen.dart';
import 'features/library/library_screen.dart';
import 'features/reader/reader_screen.dart';
import 'features/search/search_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/shell/app_shell.dart';
import 'features/study/study_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/explore',
                builder: (context, state) => ExploreScreen(
                  section: state.uri.queryParameters['section'],
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/study',
                builder: (context, state) =>
                    StudyScreen(section: state.uri.queryParameters['section']),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/collection/:collectionId',
        builder: (context, state) => CollectionScreen(
          collectionId: state.pathParameters['collectionId']!,
        ),
      ),
      GoRoute(
        path: '/document/:documentId',
        builder: (context, state) => ReaderScreen(
          documentId: state.pathParameters['documentId']!,
          initialBlockId: state.uri.queryParameters['block'],
        ),
      ),
      GoRoute(
        path: '/bible/:collectionId',
        builder: (context, state) =>
            BibleScreen(collectionId: state.pathParameters['collectionId']!),
        routes: <RouteBase>[
          GoRoute(
            path: ':bookId/:chapter',
            builder: (context, state) => BibleScreen(
              collectionId: state.pathParameters['collectionId']!,
              bookId: state.pathParameters['bookId']!,
              chapter: int.tryParse(state.pathParameters['chapter'] ?? ''),
              verse: int.tryParse(state.uri.queryParameters['verse'] ?? ''),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/ask-library',
        builder: (context, state) => const AskLibraryScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

class PropheticArchiveApp extends ConsumerWidget {
  const PropheticArchiveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingCompleteProvider);
    final preferences = ref.watch(readerPreferencesProvider);
    return MaterialApp.router(
      title: 'The Prophetic Archive',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(Brightness.light, palette: preferences.palette),
      darkTheme: buildAppTheme(Brightness.dark, palette: preferences.palette),
      themeMode: preferences.palette == ReaderPalette.light
          ? ThemeMode.light
          : ThemeMode.dark,
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) {
        return onboarding.when(
          loading: () => const _SplashScreen(),
          error: (error, stack) => _StartupError(error: error),
          data: (complete) => complete
              ? child ?? const SizedBox.shrink()
              : OnboardingScreen(
                  onFinished: () {
                    ref.invalidate(onboardingCompleteProvider);
                  },
                ),
        );
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: AppColors.burgundy,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.auto_stories_rounded, color: AppColors.gold, size: 72),
          SizedBox(height: 20),
          Text(
            'THE PROPHETIC ARCHIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class _StartupError extends StatelessWidget {
  const _StartupError({required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'The library could not be opened.\n\n$error',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({required this.onFinished, super.key});
  final VoidCallback onFinished;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final Set<String> _selected = <String>{};
  bool _working = false;

  Future<void> _finish({required bool download}) async {
    setState(() => _working = true);
    final repository = ref.read(archiveRepositoryProvider);
    if (download) {
      for (final collectionId in _selected) {
        await repository.downloadCollection(collectionId);
      }
    }
    await repository.setValue('onboarding_complete', 'true');
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final collections = ref.watch(collectionsProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Spacer(),
                  Icon(
                    Icons.auto_stories_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'The Prophetic Archive',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'The Capstone Digital Library',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Choose lightweight text collections to make them available offline. PDFs and scans remain separate downloads.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    flex: 2,
                    child: collections.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(child: Text('$error')),
                      data: (items) => ListView(
                        children: items
                            .map(
                              (collection) => CheckboxListTile(
                                value: _selected.contains(collection.id),
                                title: Text(collection.name),
                                subtitle: Text(
                                  <String>[
                                    collection.countLabel,
                                    if (collection.downloadSize > 0)
                                      _formatBytes(collection.downloadSize),
                                  ].join(' • '),
                                ),
                                onChanged: _working
                                    ? null
                                    : (selected) => setState(() {
                                        selected == true
                                            ? _selected.add(collection.id)
                                            : _selected.remove(collection.id);
                                      }),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _working || _selected.isEmpty
                        ? null
                        : () => _finish(download: true),
                    icon: _working
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.download_rounded),
                    label: const Text('Download selected'),
                  ),
                  TextButton(
                    onPressed: _working ? null : () => _finish(download: false),
                    child: const Text('Skip for now'),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}
