import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({required this.collectionId, super.key});
  final String collectionId;

  Future<void> _download(BuildContext context, WidgetRef ref) async {
    Timer? refreshTimer;
    try {
      final download = ref
          .read(archiveRepositoryProvider)
          .downloadCollection(collectionId);
      refreshTimer = Timer.periodic(
        const Duration(milliseconds: 250),
        (_) => ref.invalidate(downloadJobsProvider),
      );
      await download;
      ref
        ..invalidate(downloadStatesProvider)
        ..invalidate(downloadJobsProvider)
        ..invalidate(documentsProvider(collectionId))
        ..invalidate(storageSummaryProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Collection is available offline.')),
        );
      }
    } catch (error) {
      ref
        ..invalidate(downloadStatesProvider)
        ..invalidate(downloadJobsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      refreshTimer?.cancel();
    }
  }

  Future<void> _cancel(WidgetRef ref) async {
    await ref.read(archiveRepositoryProvider).cancel(collectionId);
    ref.invalidate(downloadJobsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogue = ref.watch(catalogueProvider);
    final documents = ref.watch(documentsProvider(collectionId));
    final downloadJobs = ref.watch(downloadJobsProvider);
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
      body: Builder(
        builder: (context) {
          final job = downloadJobs.value?[collectionId];
          final downloading = job?.state == 'downloading';
          return Column(
            children: <Widget>[
              if (downloading)
                _DownloadBanner(job: job!, onCancel: () => _cancel(ref)),
              Expanded(
                child: documents.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('$error')),
                  data: (items) {
                    if (items.isEmpty) {
                      if (downloadJobs.isLoading && job == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return _CollectionDownloadPrompt(
                        collectionName: collection?.name ?? 'this collection',
                        state: job?.state ?? 'not_downloaded',
                        errorMessage: job?.errorMessage,
                        onDownload: () => _download(context, ref),
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
                        for (final document in pages)
                          _DocumentTile(document: document),
                        for (final document in normal)
                          _DocumentTile(document: document),
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
                                        part.partLabel ??
                                            'Part ${part.partNumber}',
                                      ),
                                      subtitle: const Text(
                                        'Independent document and search target',
                                      ),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () =>
                                          context.push('/document/${part.id}'),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CollectionDownloadPrompt extends StatelessWidget {
  const _CollectionDownloadPrompt({
    required this.collectionName,
    required this.state,
    required this.onDownload,
    this.errorMessage,
  });

  final String collectionName;
  final String state;
  final String? errorMessage;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final downloading = state == 'downloading';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              downloading ? Icons.downloading : Icons.cloud_download_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              downloading
                  ? '$collectionName is downloading.'
                  : 'Download $collectionName to read and search it offline.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (errorMessage != null) ...<Widget>[
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            if (!downloading) ...<Widget>[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onDownload,
                icon: const Icon(Icons.download),
                label: Text(state == 'error' ? 'Retry download' : 'Download'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DownloadBanner extends StatelessWidget {
  const _DownloadBanner({required this.job, required this.onCancel});

  final DownloadJob job;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
      child: Row(
        children: <Widget>[
          Expanded(child: LinearProgressIndicator(value: job.progress)),
          const SizedBox(width: 12),
          Text(
            job.progress == null
                ? 'Preparing…'
                : '${(job.progress! * 100).round()}%',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          IconButton(
            tooltip: 'Cancel download',
            onPressed: onCancel,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    ),
  );
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
          if (document.showsPdf) 'PDF',
          if (document.hasOriginalScan) 'Original Scan',
        ].join(' • '),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/document/${document.id}'),
    ),
  );
}
