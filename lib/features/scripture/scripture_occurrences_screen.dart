import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';
import '../../core/scripture/scripture_reference_parser.dart';

class ScriptureOccurrencesScreen extends ConsumerStatefulWidget {
  const ScriptureOccurrencesScreen({
    required this.bookId,
    required this.chapter,
    this.verse,
    super.key,
  });

  final String bookId;
  final int chapter;
  final int? verse;

  @override
  ConsumerState<ScriptureOccurrencesScreen> createState() =>
      _ScriptureOccurrencesScreenState();
}

class _ScriptureOccurrencesScreenState
    extends ConsumerState<ScriptureOccurrencesScreen> {
  String? _collectionFilter;

  @override
  Widget build(BuildContext context) {
    final request = (
      bookId: widget.bookId,
      chapter: widget.chapter,
      verse: widget.verse,
      collectionId: null,
      chapterOnly: widget.verse == null,
    );
    final occurrences = ref.watch(scriptureOccurrencesProvider(request));
    final related = widget.verse == null
        ? const AsyncValue<List<ScriptureOccurrence>>.data(
            <ScriptureOccurrence>[],
          )
        : ref.watch(
            scriptureOccurrencesProvider((
              bookId: widget.bookId,
              chapter: widget.chapter,
              verse: null,
              collectionId: null,
              chapterOnly: true,
            )),
          );
    final bookName = ScriptureReferenceParser.bookNameFor(widget.bookId);
    final canonical =
        '$bookName ${widget.chapter}${widget.verse == null ? '' : ':${widget.verse}'}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where mentioned'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: occurrences.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Could not load occurrences: $error')),
        data: (allItems) {
          final collections = <String, String>{
            for (final item in allItems) item.collectionId: item.collectionName,
          };
          final items = _collectionFilter == null
              ? allItems
              : allItems
                    .where((item) => item.collectionId == _collectionFilter)
                    .toList();
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        canonical,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      _KjvVerseHeader(
                        bookId: widget.bookId,
                        chapter: widget.chapter,
                        verse: widget.verse,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        '${items.length} direct ${items.length == 1 ? 'occurrence' : 'occurrences'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (collections.length > 1) ...<Widget>[
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              FilterChip(
                                label: const Text('All collections'),
                                selected: _collectionFilter == null,
                                onSelected: (_) =>
                                    setState(() => _collectionFilter = null),
                              ),
                              for (final entry in collections.entries)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: FilterChip(
                                    label: Text(entry.value),
                                    selected: _collectionFilter == entry.key,
                                    onSelected: (_) => setState(
                                      () => _collectionFilter = entry.key,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (items.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No direct archive occurrences found.'),
                  ),
                )
              else
                SliverList.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      _OccurrenceCard(item: items[index]),
                ),
              if (related.value case final chapterItems?
                  when chapterItems.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                    child: Text(
                      'Related chapter references',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              if (related.value case final chapterItems?
                  when chapterItems.isNotEmpty)
                SliverList.builder(
                  itemCount: chapterItems.length,
                  itemBuilder: (context, index) =>
                      _OccurrenceCard(item: chapterItems[index], related: true),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }
}

class _KjvVerseHeader extends ConsumerWidget {
  const _KjvVerseHeader({
    required this.bookId,
    required this.chapter,
    this.verse,
  });

  final String bookId;
  final int chapter;
  final int? verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kjv = ref.watch(kjvCollectionProvider).value;
    final installed =
        ref.watch(installedCollectionIdsProvider).value ?? const <String>{};
    if (kjv == null || !installed.contains(kjv.id)) {
      return const Text(
        'KJV text is not downloaded. Occurrence results remain available offline.',
      );
    }
    return FutureBuilder<List<BibleVerse>>(
      future: ref
          .read(archiveRepositoryProvider)
          .getBibleVerses(kjv.id, bookId, chapter),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        if (verse == null) {
          return Text(
            'KJV chapter reference',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        }
        final found = snapshot.data!
            .where((item) => item.verse == verse)
            .firstOrNull;
        return found == null
            ? const Text('KJV verse text is unavailable.')
            : SelectableText(
                found.text,
                style: Theme.of(context).textTheme.bodyLarge,
              );
      },
    );
  }
}

class _OccurrenceCard extends StatelessWidget {
  const _OccurrenceCard({required this.item, this.related = false});

  final ScriptureOccurrence item;
  final bool related;

  @override
  Widget build(BuildContext context) {
    final snippet = item.snippet;
    final matchStart = snippet.indexOf(item.rawText);
    final textSpans = matchStart < 0
        ? <InlineSpan>[TextSpan(text: snippet)]
        : <InlineSpan>[
            TextSpan(text: snippet.substring(0, matchStart)),
            TextSpan(
              text: snippet.substring(
                matchStart,
                matchStart + item.rawText.length,
              ),
              style: TextStyle(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.tertiaryContainer,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: snippet.substring(matchStart + item.rawText.length)),
          ];
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.collectionName,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 2),
            Text(
              '${item.documentTitle}${item.blockLabel == null ? '' : ' · Point ${item.blockLabel}'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (related)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Chapter reference — not counted as a direct verse occurrence',
                ),
              ),
            const SizedBox(height: 10),
            Text.rich(TextSpan(children: textSpans)),
            const SizedBox(height: 8),
            Text('Printed as: ${item.rawText}'),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => context.push(
                  '/document/${item.documentId}?block=${Uri.encodeComponent(item.blockId)}'
                  '&referenceStart=${item.startOffset}&referenceEnd=${item.endOffset}',
                ),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open passage'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
