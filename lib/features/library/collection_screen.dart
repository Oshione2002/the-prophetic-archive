import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({required this.collectionId, super.key});
  final String collectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogue = ref.watch(catalogueProvider);
    final documents = ref.watch(documentsProvider(collectionId));
    final monthlyOldestFirst =
        ref.watch(monthlyOldestFirstProvider).value ?? false;
    final collection = catalogue.value?.collections.firstWhereOrNull(
      (item) => item.id == collectionId,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(collection?.name ?? 'Collection'),
        actions: <Widget>[
          if (collectionId == 'monthly-letters')
            IconButton(
              tooltip: monthlyOldestFirst
                  ? 'Showing oldest first'
                  : 'Showing newest first',
              onPressed: () async {
                await ref
                    .read(archiveRepositoryProvider)
                    .setValue(
                      'monthly_oldest_first',
                      (!monthlyOldestFirst).toString(),
                    );
                ref.invalidate(monthlyOldestFirstProvider);
              },
              icon: Icon(
                monthlyOldestFirst ? Icons.arrow_upward : Icons.arrow_downward,
              ),
            ),
        ],
      ),
      body: documents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Choose this collection in Library to make it available offline.',
              ),
            );
          }
          final pages = items.where((item) => item.isPage).toList();
          final normal = items
              .where((item) => !item.isPage && !item.isMultipart)
              .toList();
          if (collectionId == 'monthly-letters') {
            normal.sort(
              (a, b) => monthlyOldestFirst
                  ? a.sortOrder.compareTo(b.sortOrder)
                  : b.sortOrder.compareTo(a.sortOrder),
            );
          }
          final parts = items
              .where((item) => item.isMultipart)
              .groupListsBy((item) => item.groupingNumber);
          return ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              if (collection != null) ...<Widget>[
                Text(
                  collection.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  collection.countLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
              ],
              for (final document in pages) _DocumentTile(document: document),
              for (final document in normal) _DocumentTile(document: document),
              for (final entry in parts.entries)
                Card(
                  child: ExpansionTile(
                    leading: const Icon(Icons.library_books_outlined),
                    title: Text('Scroll ${entry.key}'),
                    subtitle: Text('${entry.value.length} Parts'),
                    children: entry.value
                        .map(
                          (part) => ListTile(
                            contentPadding: const EdgeInsets.only(
                              left: 40,
                              right: 16,
                            ),
                            title: Text(
                              part.partLabel ?? 'Part ${part.partNumber}',
                            ),
                            subtitle: const Text(
                              'Independent document and search target',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push('/document/${part.id}'),
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({required this.document});
  final ArchiveDocument document;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      leading: Icon(
        document.isPage ? Icons.description_outlined : Icons.menu_book_outlined,
      ),
      title: Text(document.displayTitle),
      subtitle: Text(
        [
          if (document.hasResponsiveText) 'Read',
          if (document.hasCleanPdf) 'PDF',
          if (document.hasOriginalScan) 'Original Scan',
        ].join(' • '),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/document/${document.id}'),
    ),
  );
}
