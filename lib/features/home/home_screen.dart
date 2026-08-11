import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);
    final states = ref.watch(downloadStatesProvider);
    final history = ref.watch(readingHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Prophetic Archive'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(archiveRepositoryProvider)
              .updateDownloadedCollections();
          ref.invalidate(catalogueProvider);
          ref.invalidate(collectionsProvider);
          ref.invalidate(downloadStatesProvider);
          ref.invalidate(readingHistoryProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: <Widget>[
            Text(
              'The Capstone Digital Library',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'A dedicated offline archive for reading, searching, and study.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            Text(
              'Continue Reading',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            history.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => Text('$error'),
              data: (items) => items.isEmpty
                  ? const _EmptyCard(
                      icon: Icons.menu_book_outlined,
                      text:
                          'Open a document and your reading position will appear here.',
                    )
                  : _ContinueCard(progress: items.first),
            ),
            const SizedBox(height: 28),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Collections',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'View all collections',
                  onPressed: () => context.go('/library'),
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            collections.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => Text('$error'),
              data: (items) => states.when(
                loading: () => const LinearProgressIndicator(),
                error: (error, stack) => Text('$error'),
                data: (downloadStates) => LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 1000
                        ? 4
                        : constraints.maxWidth >= 600
                        ? 2
                        : 1;
                    return GridView.count(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 2.8 : 1.45,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: items
                          .take(4)
                          .map(
                            (collection) => _CollectionCard(
                              collection: collection,
                              state:
                                  downloadStates[collection.id] ??
                                  'not_downloaded',
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text('Quick Access', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                _QuickButton(
                  icon: Icons.menu_book,
                  label: 'Bible References',
                  onTap: () => context.go('/explore?section=scripture'),
                ),
                _QuickButton(
                  icon: Icons.sell_outlined,
                  label: 'Topics',
                  onTap: () => context.go('/explore?section=topics'),
                ),
                _QuickButton(
                  icon: Icons.timeline,
                  label: 'Timeline',
                  onTap: () => context.go('/explore?section=timeline'),
                ),
                _QuickButton(
                  icon: Icons.bookmark_outline,
                  label: 'Bookmarks',
                  onTap: () => context.go('/study?section=bookmarks'),
                ),
                _QuickButton(
                  icon: Icons.auto_awesome,
                  label: 'Ask the Library',
                  onTap: () => context.push('/ask-library'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({required this.collection, required this.state});
  final CollectionSummary collection;
  final String state;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(AppRadius.card),
      onTap: () => context.push(
        collection.capabilities.bibleReader
            ? '/bible/${collection.id}'
            : '/collection/${collection.id}',
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.collections_bookmark_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            Text(
              collection.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(collection.countLabel),
            const Spacer(),
            Text(
              switch (state) {
                'downloaded' => 'Available offline',
                'update_available' => 'Update available',
                'downloading' => 'Downloading',
                _ => 'Not downloaded',
              },
              style: TextStyle(
                color: state == 'downloaded' || state == 'update_available'
                    ? Colors.green.shade700
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.progress});
  final ReadingProgressRecord progress;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.all(18),
      leading: const CircleAvatar(child: Icon(Icons.play_arrow_rounded)),
      title: Text(progress.documentTitle),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: LinearProgressIndicator(value: progress.percentage),
      ),
      trailing: Text('${(progress.percentage * 100).round()}%'),
      onTap: () => context.push(
        '/document/${progress.documentId}${progress.lastBlockId == null ? '' : '?block=${Uri.encodeQueryComponent(progress.lastBlockId!)}'}',
      ),
    ),
  );
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 14),
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}

class _QuickButton extends StatelessWidget {
  const _QuickButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ActionChip(
    avatar: Icon(icon, size: 19),
    label: Text(label),
    onPressed: onTap,
  );
}
