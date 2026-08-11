import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  bool _checkingForUpdates = false;

  Future<void> _updateContent() async {
    if (_checkingForUpdates) return;
    setState(() => _checkingForUpdates = true);
    Timer? refreshTimer;
    try {
      refreshTimer = Timer.periodic(
        const Duration(milliseconds: 300),
        (_) => ref.invalidate(downloadJobsProvider),
      );
      final count = await ref
          .read(archiveRepositoryProvider)
          .updateDownloadedCollections();
      ref
        ..invalidate(catalogueProvider)
        ..invalidate(collectionsProvider)
        ..invalidate(downloadStatesProvider)
        ..invalidate(downloadJobsProvider)
        ..invalidate(installedCollectionIdsProvider)
        ..invalidate(documentsProvider)
        ..invalidate(documentProvider)
        ..invalidate(blocksProvider)
        ..invalidate(topicsProvider)
        ..invalidate(scriptureReferencesProvider)
        ..invalidate(timelineProvider)
        ..invalidate(storageSummaryProvider);
      if (mounted) {
        final message = count == 0
            ? 'Library is up to date.'
            : '$count new or updated ${count == 1 ? 'collection is' : 'collections are'} available.';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Update failed: $error')));
      }
    } finally {
      refreshTimer?.cancel();
      if (mounted) setState(() => _checkingForUpdates = false);
    }
  }

  Future<void> _download(BuildContext context, WidgetRef ref, String id) async {
    Timer? refreshTimer;
    try {
      final download = ref
          .read(archiveRepositoryProvider)
          .downloadCollection(id);
      refreshTimer = Timer.periodic(
        const Duration(milliseconds: 300),
        (_) => ref.invalidate(downloadJobsProvider),
      );
      await download;
      ref.invalidate(downloadStatesProvider);
      ref.invalidate(downloadJobsProvider);
      ref.invalidate(installedCollectionIdsProvider);
      ref.invalidate(documentsProvider(id));
      ref.invalidate(storageSummaryProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Collection is available offline.')),
        );
      }
    } catch (error) {
      ref.invalidate(downloadStatesProvider);
      ref.invalidate(downloadJobsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      refreshTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final collections = ref.watch(collectionsProvider);
    final jobs = ref.watch(downloadJobsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: IconButton(
              tooltip: 'Check for content updates',
              onPressed: _checkingForUpdates ? null : _updateContent,
              icon: _checkingForUpdates
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.sync),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: 'Settings',
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings_outlined),
            ),
          ),
        ],
      ),
      body: collections.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (items) => jobs.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('$error')),
          data: (downloadJobs) => ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final collection = items[index];
              final job = downloadJobs[collection.id];
              return _LibraryCard(
                collection: collection,
                job: job,
                onOpen: () => context.push(
                  collection.capabilities.bibleReader
                      ? '/bible/${collection.id}'
                      : '/collection/${collection.id}',
                ),
                onDownload: () => _download(context, ref, collection.id),
                onCancel: () async {
                  await ref
                      .read(archiveRepositoryProvider)
                      .cancel(collection.id);
                  ref.invalidate(downloadJobsProvider);
                },
                onRemove: () => _remove(context, ref, collection),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    CollectionSummary collection,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${collection.name}?'),
        content: const Text(
          'Downloaded archive files will be removed. Your bookmarks, highlights, notes, and reading history will be kept.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(archiveRepositoryProvider).removeCollection(collection.id);
    ref
      ..invalidate(downloadStatesProvider)
      ..invalidate(downloadJobsProvider)
      ..invalidate(installedCollectionIdsProvider)
      ..invalidate(documentsProvider(collection.id))
      ..invalidate(storageSummaryProvider);
  }
}

class _LibraryCard extends StatelessWidget {
  const _LibraryCard({
    required this.collection,
    required this.job,
    required this.onOpen,
    required this.onDownload,
    required this.onCancel,
    required this.onRemove,
  });

  final CollectionSummary collection;
  final DownloadJob? job;
  final VoidCallback onOpen;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final state = job?.state ?? 'not_downloaded';
    final downloaded = state == 'downloaded' || state == 'update_available';
    final downloading = state == 'downloading';
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 26,
                child: Icon(
                  downloaded
                      ? Icons.offline_pin
                      : Icons.cloud_download_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      collection.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(collection.description),
                    const SizedBox(height: 8),
                    Text(
                      <String>[
                        collection.countLabel,
                        if (collection.downloadSize > 0)
                          _formatBytes(collection.downloadSize),
                        _stateLabel(state),
                      ].join(' • '),
                    ),
                    if (downloading)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: LinearProgressIndicator(
                                value: job?.progress,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(_progressLabel(job)),
                          ],
                        ),
                      ),
                    if (job?.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          job!.errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    if (!downloaded || state == 'update_available') ...<Widget>[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: <Widget>[
                          if (!downloading)
                            FilledButton.icon(
                              onPressed: onDownload,
                              icon: const Icon(Icons.download),
                              label: Text(
                                state == 'error'
                                    ? 'Retry'
                                    : state == 'update_available'
                                    ? 'Update'
                                    : 'Download',
                              ),
                            ),
                          if (downloading)
                            TextButton(
                              onPressed: onCancel,
                              child: const Text('Cancel'),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (downloaded)
                IconButton(
                  tooltip: 'Delete downloaded collection',
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _stateLabel(String state) => switch (state) {
  'downloaded' => 'Downloaded',
  'downloading' => 'Downloading',
  'error' => 'Error',
  'update_available' => 'Update available',
  _ => 'Not downloaded',
};

String _progressLabel(DownloadJob? job) =>
    job?.progress == null ? 'Preparing…' : '${(job!.progress! * 100).round()}%';

String _formatBytes(int bytes) => bytes < 1024 * 1024
    ? '${(bytes / 1024).toStringAsFixed(0)} KB'
    : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
