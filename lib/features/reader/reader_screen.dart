import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';
import '../../core/repositories/contracts.dart';
import '../../core/theme/app_theme.dart';

enum _ReaderMode { read, cleanPdf, originalScan }

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({
    required this.documentId,
    this.initialBlockId,
    super.key,
  });
  final String documentId;
  final String? initialBlockId;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  late final TextToSpeechService _ttsService;
  _ReaderMode _mode = _ReaderMode.read;
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _blockKeys = <String, GlobalKey>{};
  DocumentBlock? _selectedBlock;
  TextSelection? _selection;
  bool _jumpScheduled = false;
  bool _speaking = false;
  bool _ttsPaused = false;
  double _ttsRate = 1.0;
  bool _assetWorking = false;

  @override
  void initState() {
    super.initState();
    _ttsService = ref.read(ttsServiceProvider);
  }

  @override
  void dispose() {
    _ttsService.stop();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _toggleBookmark(ArchiveDocument document) async {
    await ref.read(archiveRepositoryProvider).toggleBookmark(document);
    ref.invalidate(bookmarksProvider);
    setState(() {});
  }

  Future<void> _saveHighlight() async {
    final block = _selectedBlock;
    final selection = _selection;
    if (block == null || selection == null || selection.isCollapsed) return;
    final start = selection.start.clamp(0, block.text.length);
    final end = selection.end.clamp(0, block.text.length);
    if (end <= start) return;
    await ref
        .read(archiveRepositoryProvider)
        .addHighlight(
          documentId: block.documentId,
          blockId: block.id,
          startOffset: start,
          endOffset: end,
          selectedText: block.text.substring(start, end),
        );
    ref.invalidate(highlightsProvider);
    if (mounted) {
      setState(() => _selection = null);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Highlight saved.')));
    }
  }

  Future<void> _addNote(ArchiveDocument document) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add note'),
        content: TextField(
          controller: controller,
          autofocus: true,
          minLines: 4,
          maxLines: 10,
          decoration: const InputDecoration(hintText: 'Write a private note…'),
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
    if (result == null || result.isEmpty) return;
    await ref
        .read(archiveRepositoryProvider)
        .addNote(document, result, blockId: _selectedBlock?.id);
    ref.invalidate(notesProvider);
  }

  Future<void> _startTts(List<DocumentBlock> blocks) async {
    setState(() {
      _speaking = true;
      _ttsPaused = false;
    });
    try {
      await _ttsService.speak(blocks, rate: _ttsRate);
    } finally {
      if (mounted) {
        setState(() {
          _speaking = false;
          _ttsPaused = false;
        });
      }
    }
  }

  Future<void> _toggleTtsPause() async {
    if (_ttsPaused) {
      await _ttsService.resume();
    } else {
      await _ttsService.pause();
    }
    if (mounted) setState(() => _ttsPaused = !_ttsPaused);
  }

  Future<void> _stopTts() async {
    await _ttsService.stop();
    if (mounted) {
      setState(() {
        _speaking = false;
        _ttsPaused = false;
      });
    }
  }

  void _scheduleJump(String blockId) {
    if (_jumpScheduled) return;
    _jumpScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = _blockKeys[blockId]?.currentContext;
      if (target != null) {
        Scrollable.ensureVisible(
          target,
          duration: const Duration(milliseconds: 450),
          alignment: 0.12,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final documentAsync = ref.watch(documentProvider(widget.documentId));
    final blocksAsync = ref.watch(blocksProvider(widget.documentId));
    return documentAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(body: Center(child: Text('$error'))),
      data: (document) {
        if (document == null) {
          return const Scaffold(
            body: Center(child: Text('This document is not downloaded.')),
          );
        }
        return blocksAsync.when(
          loading: () => Scaffold(
            appBar: AppBar(title: Text(document.displayTitle)),
            body: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Scaffold(
            appBar: AppBar(title: Text(document.displayTitle)),
            body: Center(child: Text('$error')),
          ),
          data: (blocks) {
            final modes = <ButtonSegment<_ReaderMode>>[
              const ButtonSegment(
                value: _ReaderMode.read,
                label: Text('Read'),
                icon: Icon(Icons.chrome_reader_mode_outlined),
              ),
              if (document.hasCleanPdf)
                const ButtonSegment(
                  value: _ReaderMode.cleanPdf,
                  label: Text('PDF'),
                  icon: Icon(Icons.picture_as_pdf_outlined),
                ),
              if (document.hasOriginalScan)
                const ButtonSegment(
                  value: _ReaderMode.originalScan,
                  label: Text('Original Scan'),
                  icon: Icon(Icons.document_scanner_outlined),
                ),
            ];
            if (!modes.any((segment) => segment.value == _mode)) {
              _mode = _ReaderMode.read;
            }
            final bookmarkFuture = ref
                .read(archiveRepositoryProvider)
                .isBookmarked(document.id);
            if (widget.initialBlockId != null) {
              _scheduleJump(widget.initialBlockId!);
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  document.displayTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: <Widget>[
                  FutureBuilder<bool>(
                    future: bookmarkFuture,
                    builder: (context, snapshot) => IconButton(
                      tooltip: snapshot.data == true
                          ? 'Remove bookmark'
                          : 'Bookmark',
                      onPressed: () => _toggleBookmark(document),
                      icon: Icon(
                        snapshot.data == true
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Add note',
                    onPressed: () => _addNote(document),
                    icon: const Icon(Icons.note_add_outlined),
                  ),
                  IconButton(
                    tooltip: 'Reader settings',
                    onPressed: _showReaderSettings,
                    icon: const Icon(Icons.text_fields),
                  ),
                ],
              ),
              body: Column(
                children: <Widget>[
                  if (modes.length > 1)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(12),
                      child: SegmentedButton<_ReaderMode>(
                        segments: modes,
                        selected: <_ReaderMode>{_mode},
                        onSelectionChanged: (value) =>
                            setState(() => _mode = value.first),
                      ),
                    ),
                  Expanded(
                    child: switch (_mode) {
                      _ReaderMode.read => _buildTextReader(document, blocks),
                      _ReaderMode.cleanPdf => _buildPdf(
                        document,
                        'clean_pdf',
                        'PDF',
                      ),
                      _ReaderMode.originalScan => _buildPdf(
                        document,
                        'original_scan',
                        'Original Scan',
                      ),
                    },
                  ),
                ],
              ),
              floatingActionButton: _mode == _ReaderMode.read
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (_selection != null && !_selection!.isCollapsed)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: FloatingActionButton.small(
                              heroTag: 'highlight',
                              tooltip: 'Highlight selection',
                              onPressed: _saveHighlight,
                              child: const Icon(Icons.border_color_outlined),
                            ),
                          ),
                        if (_speaking)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: FloatingActionButton.small(
                              heroTag: 'tts-stop',
                              tooltip: 'Stop reading aloud',
                              onPressed: _stopTts,
                              child: const Icon(Icons.stop),
                            ),
                          ),
                        if (!_speaking)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: PopupMenuButton<double>(
                              tooltip: 'Reading speed',
                              initialValue: _ttsRate,
                              onSelected: (value) =>
                                  setState(() => _ttsRate = value),
                              itemBuilder: (context) =>
                                  const <PopupMenuEntry<double>>[
                                    PopupMenuItem(
                                      value: 0.5,
                                      child: Text('0.5×'),
                                    ),
                                    PopupMenuItem(
                                      value: 1.0,
                                      child: Text('1.0×'),
                                    ),
                                    PopupMenuItem(
                                      value: 1.5,
                                      child: Text('1.5×'),
                                    ),
                                    PopupMenuItem(
                                      value: 2.0,
                                      child: Text('2.0×'),
                                    ),
                                  ],
                              child: FloatingActionButton.small(
                                heroTag: 'tts-speed',
                                onPressed: null,
                                child: Text('${_ttsRate.toStringAsFixed(1)}×'),
                              ),
                            ),
                          ),
                        FloatingActionButton(
                          heroTag: 'tts',
                          tooltip: _speaking
                              ? (_ttsPaused
                                    ? 'Resume reading aloud'
                                    : 'Pause reading aloud')
                              : 'Read aloud',
                          onPressed: _speaking
                              ? _toggleTtsPause
                              : () => _startTts(blocks),
                          child: Icon(
                            _speaking
                                ? (_ttsPaused ? Icons.play_arrow : Icons.pause)
                                : Icons.volume_up_outlined,
                          ),
                        ),
                      ],
                    )
                  : null,
            );
          },
        );
      },
    );
  }

  Widget _buildTextReader(
    ArchiveDocument document,
    List<DocumentBlock> blocks,
  ) {
    final preferences = ref.watch(readerPreferencesProvider);
    final crossReferences =
        ref.watch(crossReferencesProvider(document.id)).value ??
        const <CrossReferenceRecord>[];
    final documentHighlights =
        ref
            .watch(highlightsProvider)
            .value
            ?.where((item) => item.documentId == document.id)
            .toList() ??
        const <HighlightRecord>[];
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.maxScrollExtent > 0) {
          final percentage =
              notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          final index = (percentage * (blocks.length - 1)).round().clamp(
            0,
            blocks.length - 1,
          );
          ref
              .read(archiveRepositoryProvider)
              .saveProgress(
                document,
                blockId: blocks.isEmpty ? null : blocks[index].id,
                percentage: percentage,
              );
          ref.invalidate(readingHistoryProvider);
        }
        return false;
      },
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: preferences.maxWidth),
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
            itemCount: blocks.length + (crossReferences.isEmpty ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == blocks.length) {
                return _CrossReferences(references: crossReferences);
              }
              final block = blocks[index];
              final key = _blockKeys.putIfAbsent(block.id, GlobalKey.new);
              return Container(
                key: key,
                color: widget.initialBlockId == block.id
                    ? Theme.of(
                        context,
                      ).colorScheme.secondaryContainer.withValues(alpha: 0.45)
                    : null,
                padding: EdgeInsets.only(
                  bottom: block.blockType == 'divider' ? 18 : 16,
                ),
                child: _BlockView(
                  block: block,
                  highlights: documentHighlights
                      .where((item) => item.blockId == block.id)
                      .toList(),
                  preferences: preferences,
                  onSelectionChanged: (selection) => setState(() {
                    _selectedBlock = block;
                    _selection = selection;
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPdf(ArchiveDocument document, String type, String label) {
    final asset = document.assets.firstWhereOrNull(
      (item) => item.fileType == type,
    );
    if (asset == null) {
      return Center(child: Text('$label is unavailable.'));
    }
    if (!asset.isAvailable) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.cloud_download_outlined, size: 54),
              const SizedBox(height: 16),
              Text('$label is not downloaded.'),
              if (asset.fileSize != null)
                Text(_formatAssetBytes(asset.fileSize!)),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _assetWorking
                    ? null
                    : () => _downloadAsset(document, asset),
                icon: _assetWorking
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download),
                label: Text('Download $label'),
              ),
            ],
          ),
        ),
      );
    }
    return Stack(
      children: <Widget>[
        if (asset.assetPath != null)
          PdfViewer.asset(asset.assetPath!)
        else
          PdfViewer.file(asset.localPath!),
        Positioned(
          top: 12,
          right: 12,
          child: Row(
            children: <Widget>[
              Chip(
                label: Text(label),
                avatar: const Icon(Icons.verified_outlined, size: 18),
              ),
              if (asset.localPath != null) ...<Widget>[
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: 'Remove downloaded $label',
                  onPressed: _assetWorking
                      ? null
                      : () => _removeAsset(document, asset, label),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _downloadAsset(
    ArchiveDocument document,
    DocumentAsset asset,
  ) async {
    setState(() => _assetWorking = true);
    try {
      await ref
          .read(archiveRepositoryProvider)
          .downloadAsset(document.id, asset);
      ref.invalidate(documentProvider(document.id));
      ref.invalidate(storageSummaryProvider);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _assetWorking = false);
    }
  }

  Future<void> _removeAsset(
    ArchiveDocument document,
    DocumentAsset asset,
    String label,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove $label?'),
        content: const Text(
          'The structured text and all bookmarks, highlights, notes, and reading progress will be kept.',
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
    setState(() => _assetWorking = true);
    try {
      await ref.read(archiveRepositoryProvider).removeAsset(asset.id);
      ref.invalidate(documentProvider(document.id));
      ref.invalidate(storageSummaryProvider);
      if (mounted) setState(() => _mode = _ReaderMode.read);
    } finally {
      if (mounted) setState(() => _assetWorking = false);
    }
  }

  Future<void> _showReaderSettings() async {
    final current = ref.read(readerPreferencesProvider);
    var draft = current;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Reader settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                SegmentedButton<ReaderPalette>(
                  segments: const <ButtonSegment<ReaderPalette>>[
                    ButtonSegment(
                      value: ReaderPalette.light,
                      label: Text('Light'),
                    ),
                    ButtonSegment(
                      value: ReaderPalette.sepia,
                      label: Text('Sepia'),
                    ),
                    ButtonSegment(
                      value: ReaderPalette.dark,
                      label: Text('Dark'),
                    ),
                  ],
                  selected: <ReaderPalette>{draft.palette},
                  onSelectionChanged: (value) => setSheetState(
                    () => draft = draft.copyWith(palette: value.first),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Text('Font size'),
                    Expanded(
                      child: Slider(
                        value: draft.fontSize,
                        min: 14,
                        max: 32,
                        divisions: 18,
                        label: draft.fontSize.round().toString(),
                        onChanged: (value) => setSheetState(
                          () => draft = draft.copyWith(fontSize: value),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Text('Line spacing'),
                    Expanded(
                      child: Slider(
                        value: draft.lineHeight,
                        min: 1.2,
                        max: 2.2,
                        divisions: 10,
                        onChanged: (value) => setSheetState(
                          () => draft = draft.copyWith(lineHeight: value),
                        ),
                      ),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: () {
                    ref.read(readerPreferencesProvider.notifier).update(draft);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CrossReferences extends StatelessWidget {
  const _CrossReferences({required this.references});
  final List<CrossReferenceRecord> references;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Referenced documents',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        for (final reference in references)
          Card(
            child: ListTile(
              leading: const Icon(Icons.link),
              title: Text(reference.linkedDocumentTitle),
              subtitle: Text(
                reference.direction == 'referenced_by'
                    ? 'Referenced by'
                    : reference.displayText,
              ),
              onTap: () =>
                  context.push('/document/${reference.linkedDocumentId}'),
            ),
          ),
      ],
    ),
  );
}

String _formatAssetBytes(int bytes) => bytes < 1024 * 1024
    ? '${(bytes / 1024).toStringAsFixed(0)} KB'
    : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';

class _BlockView extends StatelessWidget {
  const _BlockView({
    required this.block,
    required this.highlights,
    required this.preferences,
    required this.onSelectionChanged,
  });
  final DocumentBlock block;
  final List<HighlightRecord> highlights;
  final ReaderPreferences preferences;
  final ValueChanged<TextSelection> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    if (block.blockType == 'divider') return const Divider();
    final base = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontFamily: 'SourceSerif4',
      fontSize: preferences.fontSize,
      height: preferences.lineHeight,
    );
    final style = switch (block.blockType) {
      'heading' => Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontSize: preferences.fontSize + (block.headingLevel == 1 ? 10 : 6),
        height: 1.25,
        fontWeight: FontWeight.bold,
      ),
      'quotation' => base.copyWith(
        fontStyle: FontStyle.italic,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      'scripture_reference' => base.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      _ => base,
    };
    final prefix = block.blockType == 'numbered_item'
        ? '${block.numberLabel}.  '
        : '';
    final spans = <InlineSpan>[];
    if (prefix.isNotEmpty) spans.add(TextSpan(text: prefix));
    var cursor = 0;
    final ranges = highlights.toList()
      ..sort((a, b) => a.startOffset.compareTo(b.startOffset));
    for (final highlight in ranges) {
      final start = highlight.startOffset.clamp(cursor, block.text.length);
      final end = highlight.endOffset.clamp(start, block.text.length);
      if (start > cursor) {
        spans.add(TextSpan(text: block.text.substring(cursor, start)));
      }
      if (end > start) {
        spans.add(
          TextSpan(
            text: block.text.substring(start, end),
            style: TextStyle(
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        );
      }
      cursor = end;
    }
    if (cursor < block.text.length) {
      spans.add(TextSpan(text: block.text.substring(cursor)));
    }
    return Semantics(
      label: block.blockType == 'numbered_item'
          ? 'Point ${block.numberLabel}'
          : null,
      child: SelectableText.rich(
        TextSpan(style: style, children: spans),
        onSelectionChanged: (selection, cause) {
          final prefixLength = prefix.length;
          onSelectionChanged(
            TextSelection(
              baseOffset: (selection.baseOffset - prefixLength).clamp(
                0,
                block.text.length,
              ),
              extentOffset: (selection.extentOffset - prefixLength).clamp(
                0,
                block.text.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
