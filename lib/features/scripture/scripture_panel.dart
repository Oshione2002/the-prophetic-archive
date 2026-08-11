import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';
import '../../core/scripture/scripture_reference_parser.dart';

class ScripturePanel extends ConsumerStatefulWidget {
  const ScripturePanel({
    required this.reference,
    required this.onClose,
    super.key,
  });

  final ScriptureReferenceSpan reference;
  final VoidCallback onClose;

  @override
  ConsumerState<ScripturePanel> createState() => _ScripturePanelState();
}

class _ScripturePanelState extends ConsumerState<ScripturePanel> {
  Timer? _progressTimer;
  bool _startingDownload = false;

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  Future<void> _download(CollectionSummary collection) async {
    setState(() => _startingDownload = true);
    _progressTimer = Timer.periodic(const Duration(milliseconds: 350), (_) {
      ref.invalidate(downloadJobsProvider);
      ref.invalidate(downloadStatesProvider);
    });
    try {
      await ref
          .read(archiveRepositoryProvider)
          .downloadCollection(collection.id);
      ref
        ..invalidate(installedCollectionIdsProvider)
        ..invalidate(downloadJobsProvider)
        ..invalidate(downloadStatesProvider)
        ..invalidate(bibleBooksProvider(collection.id));
      if (mounted) setState(() {});
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('KJV download failed: $error')));
      }
    } finally {
      _progressTimer?.cancel();
      if (mounted) setState(() => _startingDownload = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kjv = ref.watch(kjvCollectionProvider);
    final installed =
        ref.watch(installedCollectionIdsProvider).value ?? const <String>{};
    final jobs =
        ref.watch(downloadJobsProvider).value ?? const <String, DownloadJob>{};
    final maxHeight = MediaQuery.sizeOf(context).height * 0.46;
    return Semantics(
      container: true,
      label: 'Scripture reference panel',
      child: Material(
        key: const ValueKey('scripture-panel'),
        elevation: 16,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight, minHeight: 190),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 8, 6),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.reference.canonicalReference,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const Text('King James Version'),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Copy passage',
                        onPressed: () => _copyPassage(kjv.value),
                        icon: const Icon(Icons.copy_outlined),
                      ),
                      IconButton(
                        tooltip: 'Close Scripture panel',
                        autofocus: true,
                        onPressed: widget.onClose,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Flexible(
                  child: kjv.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => const _UnavailableKjv(),
                    data: (collection) {
                      if (collection == null) return const _UnavailableKjv();
                      if (!installed.contains(collection.id)) {
                        final job = jobs[collection.id];
                        return _DownloadKjv(
                          collection: collection,
                          job: job,
                          starting: _startingDownload,
                          onDownload: () => _download(collection),
                          reference: widget.reference,
                        );
                      }
                      return FutureBuilder<List<BibleVerse>>(
                        future: ref
                            .read(archiveRepositoryProvider)
                            .getBibleVersesForSegments(
                              collection.id,
                              widget.reference.segments,
                            ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final verses = snapshot.data!;
                          if (verses.isEmpty) {
                            return const Center(
                              child: Text(
                                'This KJV passage is unavailable offline.',
                              ),
                            );
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
                            itemCount: verses.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 14),
                            itemBuilder: (context, index) => _VerseRow(
                              verse: verses[index],
                              onWhereMentioned: () =>
                                  _openOccurrences(verses[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                  child: Row(
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () => _openFirstOccurrence(),
                        icon: const Icon(Icons.manage_search),
                        label: const Text('Where mentioned'),
                      ),
                      const Spacer(),
                      if (kjv.value case final collection?
                          when installed.contains(collection.id))
                        TextButton.icon(
                          onPressed: () {
                            final segment = widget.reference.segments.first;
                            context.push(
                              '/bible/${collection.id}/${segment.bookId}/${segment.chapter}'
                              '${segment.verseStart == null ? '' : '?verse=${segment.verseStart}'}',
                            );
                          },
                          icon: const Icon(Icons.menu_book_outlined),
                          label: const Text('Open in KJV'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _copyPassage(CollectionSummary? collection) async {
    if (collection == null) return;
    final installed = await ref.read(installedCollectionIdsProvider.future);
    if (!installed.contains(collection.id)) return;
    final verses = await ref
        .read(archiveRepositoryProvider)
        .getBibleVersesForSegments(collection.id, widget.reference.segments);
    final text = verses
        .map(
          (verse) =>
              '${verse.bookName} ${verse.chapter}:${verse.verse} ${verse.text}',
        )
        .join('\n');
    if (text.isNotEmpty) await Clipboard.setData(ClipboardData(text: text));
  }

  void _openOccurrences(BibleVerse verse) {
    context.push(
      '/scripture/kjv/${verse.bookId}/${verse.chapter}/${verse.verse}/occurrences',
    );
  }

  void _openFirstOccurrence() {
    final segment = widget.reference.segments.first;
    final verse = segment.verseStart;
    if (verse == null) {
      context.push(
        '/scripture/kjv/${segment.bookId}/${segment.chapter}/chapter/occurrences',
      );
      return;
    }
    context.push(
      '/scripture/kjv/${segment.bookId}/${segment.chapter}/$verse/occurrences',
    );
  }
}

class _VerseRow extends StatelessWidget {
  const _VerseRow({required this.verse, required this.onWhereMentioned});

  final BibleVerse verse;
  final VoidCallback onWhereMentioned;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${verse.bookName} chapter ${verse.chapter} verse ${verse.verse}',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 34,
          child: Text(
            '${verse.verse}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(child: SelectableText(verse.text)),
        IconButton(
          tooltip:
              'Where ${verse.bookName} ${verse.chapter}:${verse.verse} is mentioned',
          onPressed: onWhereMentioned,
          icon: const Icon(Icons.manage_search, size: 20),
        ),
      ],
    ),
  );
}

class _DownloadKjv extends StatelessWidget {
  const _DownloadKjv({
    required this.collection,
    required this.job,
    required this.starting,
    required this.onDownload,
    required this.reference,
  });

  final CollectionSummary collection;
  final DownloadJob? job;
  final bool starting;
  final VoidCallback onDownload;
  final ScriptureReferenceSpan reference;

  @override
  Widget build(BuildContext context) {
    final progress = job?.progress;
    final percent = progress == null ? null : '${(progress * 100).round()}%';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Download the KJV Bible to read ${reference.canonicalReference} here. Archive occurrence results remain available without it.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            if (starting) ...<Widget>[
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              Text(percent ?? 'Preparing download…'),
            ] else
              FilledButton.icon(
                onPressed: onDownload,
                icon: const Icon(Icons.download),
                label: const Text('Download KJV'),
              ),
          ],
        ),
      ),
    );
  }
}

class _UnavailableKjv extends StatelessWidget {
  const _UnavailableKjv();

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Text(
        'The KJV collection is not currently available in the archive catalogue. No internet Bible service is used.',
        textAlign: TextAlign.center,
      ),
    ),
  );
}
