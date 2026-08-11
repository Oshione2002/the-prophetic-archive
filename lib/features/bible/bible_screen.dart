import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';

class BibleScreen extends ConsumerStatefulWidget {
  const BibleScreen({
    required this.collectionId,
    this.bookId,
    this.chapter,
    this.verse,
    super.key,
  });

  final String collectionId;
  final String? bookId;
  final int? chapter;
  final int? verse;

  @override
  ConsumerState<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends ConsumerState<BibleScreen> {
  var _speaking = false;

  @override
  void dispose() {
    ref.read(ttsServiceProvider).stop();
    super.dispose();
  }

  String _path(String bookId, int chapter, {int? verse}) =>
      '/bible/${widget.collectionId}/$bookId/$chapter'
      '${verse == null ? '' : '?verse=$verse'}';

  Future<void> _speak(List<BibleVerse> verses) async {
    if (_speaking) {
      await ref.read(ttsServiceProvider).stop();
      if (mounted) setState(() => _speaking = false);
      return;
    }
    setState(() => _speaking = true);
    final blocks = verses
        .map(
          (verse) => DocumentBlock(
            id: verse.blockId,
            documentId: verse.documentId,
            orderIndex: verse.verse,
            blockType: 'verse',
            text: '${verse.verse}. ${verse.text}',
            numberLabel: '${verse.verse}',
          ),
        )
        .toList();
    await ref.read(ttsServiceProvider).speak(blocks, rate: 1);
    if (mounted) setState(() => _speaking = false);
  }

  Future<void> _bookmark(BibleVerse verse) async {
    final repository = ref.read(archiveRepositoryProvider);
    final document = await repository.getDocument(verse.documentId);
    if (document == null) return;
    await repository.toggleBookmark(document, blockId: verse.blockId);
    ref.invalidate(bookmarksProvider);
    _message('${verse.reference} bookmark updated.');
  }

  Future<void> _highlight(BibleVerse verse) async {
    await ref
        .read(archiveRepositoryProvider)
        .addHighlight(
          documentId: verse.documentId,
          blockId: verse.blockId,
          startOffset: 0,
          endOffset: verse.text.length,
          selectedText: verse.text,
        );
    ref.invalidate(highlightsProvider);
    _message('${verse.reference} highlighted.');
  }

  Future<void> _note(BibleVerse verse) async {
    final controller = TextEditingController();
    final body = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Note on ${verse.reference}'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 5,
          decoration: const InputDecoration(hintText: 'Write a note'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (body == null || body.isEmpty) return;
    final repository = ref.read(archiveRepositoryProvider);
    final document = await repository.getDocument(verse.documentId);
    if (document == null) return;
    await repository.addNote(document, body, blockId: verse.blockId);
    ref.invalidate(notesProvider);
    _message('Note saved.');
  }

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final collection = ref
        .watch(collectionsProvider)
        .value
        ?.firstWhereOrNull((item) => item.id == widget.collectionId);
    final installed =
        ref
            .watch(installedCollectionIdsProvider)
            .value
            ?.contains(widget.collectionId) ??
        false;
    return Scaffold(
      appBar: AppBar(
        title: Text(collection?.name ?? 'Bible'),
        actions: <Widget>[
          IconButton(
            tooltip: _speaking ? 'Stop reading' : 'Read aloud',
            onPressed: widget.chapter == null
                ? null
                : () {
                    final verses = ref
                        .read(
                          bibleVersesProvider((
                            collectionId: widget.collectionId,
                            bookId: widget.bookId!,
                            chapter: widget.chapter!,
                          )),
                        )
                        .value;
                    if (verses != null) _speak(verses);
                  },
            icon: Icon(
              _speaking ? Icons.stop_circle_outlined : Icons.volume_up_outlined,
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
      body: !installed
          ? _BibleDownloadPrompt(
              name: collection?.name ?? 'this Bible',
              onDownload: () async {
                await ref
                    .read(archiveRepositoryProvider)
                    .downloadCollection(widget.collectionId);
                ref
                  ..invalidate(installedCollectionIdsProvider)
                  ..invalidate(downloadJobsProvider)
                  ..invalidate(bibleBooksProvider(widget.collectionId));
              },
            )
          : _buildInstalled(),
    );
  }

  Widget _buildInstalled() {
    final books = ref.watch(bibleBooksProvider(widget.collectionId));
    return books.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('$error')),
      data: (items) {
        if (widget.bookId == null) return _bookList(items);
        final book = items.firstWhereOrNull((item) => item.id == widget.bookId);
        if (book == null) return const Center(child: Text('Book not found.'));
        if (widget.chapter == null) return _chapterGrid(book);
        return _verseList(items, book);
      },
    );
  }

  Widget _bookList(List<BibleBook> books) => ListView(
    padding: const EdgeInsets.all(20),
    children: <Widget>[
      for (final testament
          in books.map((book) => book.testament).toSet()) ...<Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
          child: Text(testament, style: Theme.of(context).textTheme.titleLarge),
        ),
        for (final book in books.where((book) => book.testament == testament))
          Card(
            child: ListTile(
              title: Text(book.name),
              subtitle: Text('${book.chapterCount} chapters'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(_path(book.id, 1)),
            ),
          ),
      ],
    ],
  );

  Widget _chapterGrid(BibleBook book) => ListView(
    padding: const EdgeInsets.all(20),
    children: <Widget>[
      Text(book.name, style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 84,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: book.chapterCount,
        itemBuilder: (context, index) => OutlinedButton(
          onPressed: () => context.push(_path(book.id, index + 1)),
          child: Text('${index + 1}'),
        ),
      ),
    ],
  );

  Widget _verseList(List<BibleBook> books, BibleBook book) {
    final request = (
      collectionId: widget.collectionId,
      bookId: book.id,
      chapter: widget.chapter!,
    );
    return ref
        .watch(bibleVersesProvider(request))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('$error')),
          data: (verses) => Column(
            children: <Widget>[
              Material(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: book.id,
                          items: books
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.name),
                                ),
                              )
                              .toList(),
                          onChanged: (id) {
                            final selected = books.firstWhere(
                              (item) => item.id == id,
                            );
                            context.go(_path(selected.id, 1));
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<int>(
                        value: widget.chapter,
                        items: List.generate(
                          book.chapterCount,
                          (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text('${index + 1}'),
                          ),
                        ),
                        onChanged: (chapter) {
                          if (chapter != null) {
                            context.go(_path(book.id, chapter));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SelectionArea(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    itemCount: verses.length,
                    itemBuilder: (context, index) {
                      final verse = verses[index];
                      return _VerseTile(
                        verse: verse,
                        selected: widget.verse == verse.verse,
                        onSpeak: () => _speak(<BibleVerse>[verse]),
                        onBookmark: () => _bookmark(verse),
                        onHighlight: () => _highlight(verse),
                        onNote: () => _note(verse),
                        onCopy: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text:
                                  '${verse.reference} ${verse.text} (${verse.translationCode})',
                            ),
                          );
                          _message('Verse copied.');
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
  }
}

class _VerseTile extends StatelessWidget {
  const _VerseTile({
    required this.verse,
    required this.selected,
    required this.onSpeak,
    required this.onBookmark,
    required this.onHighlight,
    required this.onNote,
    required this.onCopy,
  });

  final BibleVerse verse;
  final bool selected;
  final VoidCallback onSpeak;
  final VoidCallback onBookmark;
  final VoidCallback onHighlight;
  final VoidCallback onNote;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) => Card(
    color: selected ? Theme.of(context).colorScheme.secondaryContainer : null,
    child: ListTile(
      leading: Text(
        '${verse.verse}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      title: Text(verse.text),
      onLongPress: () => showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.volume_up_outlined),
                title: const Text('Read verse'),
                onTap: () {
                  Navigator.pop(context);
                  onSpeak();
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy_outlined),
                title: const Text('Copy'),
                onTap: () {
                  Navigator.pop(context);
                  onCopy();
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark_outline),
                title: const Text('Bookmark'),
                onTap: () {
                  Navigator.pop(context);
                  onBookmark();
                },
              ),
              ListTile(
                leading: const Icon(Icons.highlight_outlined),
                title: const Text('Highlight'),
                onTap: () {
                  Navigator.pop(context);
                  onHighlight();
                },
              ),
              ListTile(
                leading: const Icon(Icons.note_add_outlined),
                title: const Text('Add note'),
                onTap: () {
                  Navigator.pop(context);
                  onNote();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _BibleDownloadPrompt extends StatelessWidget {
  const _BibleDownloadPrompt({required this.name, required this.onDownload});
  final String name;
  final Future<void> Function() onDownload;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.menu_book_outlined, size: 56),
          const SizedBox(height: 16),
          Text(
            'Download $name for offline Bible reading and search.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onDownload,
            icon: const Icon(Icons.download),
            label: const Text('Download'),
          ),
        ],
      ),
    ),
  );
}
