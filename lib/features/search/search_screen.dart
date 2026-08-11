import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _collectionId;
  bool _searching = false;
  List<SearchHit> _results = const <SearchHit>[];
  bool _hasSearched = false;
  int _searchVersion = 0;
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    _searchDebounce?.cancel();
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    final version = ++_searchVersion;
    setState(() {
      _searching = true;
      _hasSearched = true;
    });
    try {
      final results = await ref
          .read(archiveRepositoryProvider)
          .search(query, collectionId: _collectionId);
      if (mounted && version == _searchVersion) {
        setState(() => _results = results);
      }
    } finally {
      if (mounted && version == _searchVersion) {
        setState(() => _searching = false);
      }
    }
  }

  void _selectCollection(String? collectionId) {
    setState(() => _collectionId = collectionId);
    if (_controller.text.trim().isNotEmpty) _search();
  }

  void _onQueryChanged(String value) {
    _searchDebounce?.cancel();
    if (value.trim().isEmpty) {
      _searchVersion++;
      setState(() {
        _searching = false;
        _hasSearched = false;
        _results = const <SearchHit>[];
      });
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 150), _search);
  }

  @override
  Widget build(BuildContext context) {
    final collections =
        ref.watch(collectionsProvider).value ?? const <CollectionSummary>[];
    final installed =
        ref.watch(installedCollectionIdsProvider).value ?? const <String>{};
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: IconButton(
              tooltip: 'Ask the Library',
              onPressed: () => context.push('/ask-library'),
              icon: const Icon(Icons.auto_awesome_outlined),
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: TextField(
              controller: _controller,
              autofocus: false,
              textInputAction: TextInputAction.search,
              onChanged: _onQueryChanged,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                hintText: 'Search downloaded collections',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: _searching ? null : _search,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ChoiceChip(
                  label: const Text('All Downloaded'),
                  selected: _collectionId == null,
                  onSelected: (_) => _selectCollection(null),
                ),
                const SizedBox(width: 8),
                for (final collection in collections.where(
                  (collection) => installed.contains(collection.id),
                )) ...<Widget>[
                  ChoiceChip(
                    label: Text(collection.name),
                    selected: _collectionId == collection.id,
                    onSelected: (_) => _selectCollection(collection.id),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          if (_searching) const LinearProgressIndicator(),
          Expanded(
            child: !_hasSearched
                ? const _SearchEmpty(
                    icon: Icons.manage_search,
                    text:
                        'Search titles, paragraphs, numbered points, and references offline.',
                  )
                : _results.isEmpty
                ? const _SearchEmpty(
                    icon: Icons.search_off,
                    text:
                        'No results were found in your downloaded collections.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: _results.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) =>
                        _ResultCard(hit: _results[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.hit});
  final SearchHit hit;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => hit.bibleBookId == null
          ? context.push(
              '/document/${hit.documentId}?block=${Uri.encodeQueryComponent(hit.blockId)}',
            )
          : context.push(
              '/bible/${hit.collectionId}/${hit.bibleBookId}/${hit.bibleChapter}'
              '?verse=${hit.bibleVerse}',
            ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              hit.collectionName.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hit.documentTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (hit.blockLabel != null) ...<Widget>[
              const SizedBox(height: 2),
              Text(
                hit.blockLabel!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 10),
            _HighlightedText(html: hit.snippet),
          ],
        ),
      ),
    ),
  );
}

class _HighlightedText extends StatelessWidget {
  const _HighlightedText({required this.html});
  final String html;

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'<mark>(.*?)</mark>', caseSensitive: false);
    var offset = 0;
    for (final match in regex.allMatches(html)) {
      if (match.start > offset) {
        spans.add(TextSpan(text: html.substring(offset, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      );
      offset = match.end;
    }
    if (offset < html.length) spans.add(TextSpan(text: html.substring(offset)));
    return Text.rich(
      TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: spans),
    );
  }
}

class _SearchEmpty extends StatelessWidget {
  const _SearchEmpty({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 52),
          const SizedBox(height: 16),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
