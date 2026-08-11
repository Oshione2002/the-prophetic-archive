import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';
import '../../core/repositories/contracts.dart';
import '../../core/scripture/scripture_reference_parser.dart';
import '../../core/theme/app_theme.dart';
import '../audio/document_audio_controls.dart';
import '../scripture/scripture_panel.dart';

enum _ReaderMode { read, cleanPdf, originalScan }

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({
    required this.documentId,
    this.initialBlockId,
    this.initialReferenceStart,
    this.initialReferenceEnd,
    super.key,
  });
  final String documentId;
  final String? initialBlockId;
  final int? initialReferenceStart;
  final int? initialReferenceEnd;

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
  int _ttsSession = 0;
  String? _spokenBlockId;
  TextRange _spokenRange = TextRange.empty;
  bool _assetWorking = false;
  ScriptureReferenceSpan? _selectedScriptureReference;

  @override
  void initState() {
    super.initState();
    _ttsService = ref.read(ttsServiceProvider);
  }

  @override
  void dispose() {
    _ttsSession++;
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

  Future<void> _startTts(
    List<DocumentBlock> blocks, {
    int startIndex = 0,
  }) async {
    if (blocks.isEmpty) return;
    final safeStart = startIndex.clamp(0, blocks.length - 1);
    final session = ++_ttsSession;
    setState(() {
      _speaking = true;
      _ttsPaused = false;
      _spokenBlockId = blocks[safeStart].id;
      _spokenRange = TextRange.empty;
    });
    try {
      await _ttsService.speak(
        blocks.sublist(safeStart),
        rate: _ttsRate,
        onBlockChanged: (block) {
          if (!mounted || session != _ttsSession) return;
          final changed = _spokenBlockId != block.id;
          setState(() {
            _spokenBlockId = block.id;
            _spokenRange = TextRange.empty;
          });
          if (changed) _scrollToSpokenBlock(block.id);
        },
        onProgress: (block, start, end) {
          if (!mounted || session != _ttsSession) return;
          setState(() {
            _spokenBlockId = block.id;
            _spokenRange = TextRange(start: start, end: end);
          });
        },
      );
    } finally {
      if (mounted && session == _ttsSession) {
        setState(() {
          _speaking = false;
          _ttsPaused = false;
          _spokenBlockId = null;
          _spokenRange = TextRange.empty;
        });
      }
    }
  }

  void _scrollToSpokenBlock(String blockId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _spokenBlockId != blockId) return;
      final target = _blockKeys[blockId]?.currentContext;
      if (target == null) return;
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 300),
        alignment: 0.22,
      );
    });
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
    final session = ++_ttsSession;
    await _ttsService.stop();
    if (mounted && session == _ttsSession) {
      setState(() {
        _speaking = false;
        _ttsPaused = false;
        _spokenBlockId = null;
        _spokenRange = TextRange.empty;
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
              if (document.showsPdf)
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
            return CallbackShortcuts(
              bindings: <ShortcutActivator, VoidCallback>{
                const SingleActivator(LogicalKeyboardKey.escape): () {
                  if (_selectedScriptureReference != null) {
                    setState(() => _selectedScriptureReference = null);
                  }
                },
              },
              child: Scaffold(
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
                    IconButton(
                      tooltip: 'Settings',
                      onPressed: () => context.push('/settings'),
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
                body: Stack(
                  children: <Widget>[
                    Column(
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
                        if (document.hasAudio)
                          DocumentAudioControls(document: document),
                        Expanded(
                          child: switch (_mode) {
                            _ReaderMode.read => _buildTextReader(
                              document,
                              blocks,
                            ),
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
                    if (_selectedScriptureReference case final reference?)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ScripturePanel(
                          reference: reference,
                          onClose: () => setState(
                            () => _selectedScriptureReference = null,
                          ),
                        ),
                      ),
                  ],
                ),
                floatingActionButton:
                    _mode == _ReaderMode.read &&
                        _selectedScriptureReference == null
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
                                        child: Text('0.5x'),
                                      ),
                                      PopupMenuItem(
                                        value: 1.0,
                                        child: Text('1.0x'),
                                      ),
                                      PopupMenuItem(
                                        value: 1.5,
                                        child: Text('1.5x'),
                                      ),
                                      PopupMenuItem(
                                        value: 2.0,
                                        child: Text('2.0x'),
                                      ),
                                    ],
                                child: Container(
                                  width: 58,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${_ttsRate.toStringAsFixed(1)}x',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
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
                                  ? (_ttsPaused
                                        ? Icons.play_arrow
                                        : Icons.pause)
                                  : Icons.volume_up_outlined,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
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
    final scriptureReferences =
        ref.watch(scriptureReferenceSpansProvider(document.id)).value ??
        const <ScriptureReferenceSpan>[];
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useFullDesktopWidth = constraints.maxWidth >= 900;
          final readerWidth =
              useFullDesktopWidth || preferences.maxWidth > constraints.maxWidth
              ? constraints.maxWidth
              : preferences.maxWidth;
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: readerWidth,
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
                  final isSpokenBlock = _spokenBlockId == block.id;
                  return Container(
                    key: key,
                    color: isSpokenBlock || widget.initialBlockId == block.id
                        ? Theme.of(context).colorScheme.secondaryContainer
                              .withValues(alpha: 0.45)
                        : null,
                    padding: EdgeInsets.only(
                      bottom: block.blockType == 'divider' ? 18 : 16,
                    ),
                    child: _BlockView(
                      block: block,
                      scriptureReferences: scriptureReferences
                          .where(
                            (reference) => reference.id.startsWith(
                              '${block.id}:scripture:',
                            ),
                          )
                          .toList(),
                      highlights: documentHighlights
                          .where((item) => item.blockId == block.id)
                          .toList(),
                      spokenRange: isSpokenBlock
                          ? _spokenRange
                          : TextRange.empty,
                      onTap: _speaking
                          ? () =>
                                unawaited(_startTts(blocks, startIndex: index))
                          : null,
                      onScriptureTap: (reference) => setState(
                        () => _selectedScriptureReference = reference,
                      ),
                      initialReferenceRange:
                          widget.initialBlockId == block.id &&
                              widget.initialReferenceStart != null &&
                              widget.initialReferenceEnd != null
                          ? TextRange(
                              start: widget.initialReferenceStart!,
                              end: widget.initialReferenceEnd!,
                            )
                          : TextRange.empty,
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
          );
        },
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
                      value: ReaderPalette.dark,
                      label: Text('Dark'),
                    ),
                    ButtonSegment(
                      value: ReaderPalette.amoled,
                      label: Text('AMOLED'),
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

class _BlockView extends StatefulWidget {
  const _BlockView({
    required this.block,
    required this.highlights,
    required this.spokenRange,
    required this.scriptureReferences,
    required this.initialReferenceRange,
    required this.preferences,
    required this.onSelectionChanged,
    required this.onScriptureTap,
    this.onTap,
  });
  final DocumentBlock block;
  final List<HighlightRecord> highlights;
  final TextRange spokenRange;
  final List<ScriptureReferenceSpan> scriptureReferences;
  final TextRange initialReferenceRange;
  final ReaderPreferences preferences;
  final ValueChanged<TextSelection> onSelectionChanged;
  final ValueChanged<ScriptureReferenceSpan> onScriptureTap;
  final VoidCallback? onTap;

  @override
  State<_BlockView> createState() => _BlockViewState();
}

class _BlockViewState extends State<_BlockView> {
  final List<TapGestureRecognizer> _recognizers = <TapGestureRecognizer>[];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
    final block = widget.block;
    if (block.blockType == 'divider') return const Divider();
    final base = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontFamily: 'SourceSerif4',
      fontSize: widget.preferences.fontSize,
      height: widget.preferences.lineHeight,
    );
    final style = switch (block.blockType) {
      'heading' => Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontSize:
            widget.preferences.fontSize + (block.headingLevel == 1 ? 10 : 6),
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
    final spans = <InlineSpan>[if (prefix.isNotEmpty) TextSpan(text: prefix)];
    final normalizedHighlights = <({int start, int end})>[];
    final boundaries = <int>{0, block.text.length};
    for (final highlight in widget.highlights) {
      final start = highlight.startOffset.clamp(0, block.text.length);
      final end = highlight.endOffset.clamp(start, block.text.length);
      if (end <= start) continue;
      normalizedHighlights.add((start: start, end: end));
      boundaries.addAll(<int>{start, end});
    }
    final spokenStart = widget.spokenRange.start.clamp(0, block.text.length);
    final spokenEnd = widget.spokenRange.end.clamp(
      spokenStart,
      block.text.length,
    );
    if (spokenEnd > spokenStart) {
      boundaries.addAll(<int>{spokenStart, spokenEnd});
    }
    for (final reference in widget.scriptureReferences) {
      boundaries.addAll(<int>{reference.startOffset, reference.endOffset});
    }
    final initialStart = widget.initialReferenceRange.start.clamp(
      0,
      block.text.length,
    );
    final initialEnd = widget.initialReferenceRange.end.clamp(
      initialStart,
      block.text.length,
    );
    if (initialEnd > initialStart) {
      boundaries.addAll(<int>{initialStart, initialEnd});
    }
    final stops = boundaries.toList()..sort();
    for (var index = 0; index < stops.length - 1; index++) {
      final start = stops[index];
      final end = stops[index + 1];
      if (end <= start) continue;
      final isSpoken =
          spokenEnd > spokenStart && start >= spokenStart && start < spokenEnd;
      final isHighlighted = normalizedHighlights.any(
        (range) => start >= range.start && start < range.end,
      );
      final reference = widget.scriptureReferences.firstWhereOrNull(
        (item) =>
            item.isClickable &&
            start >= item.startOffset &&
            start < item.endOffset,
      );
      final isInitialReference =
          initialEnd > initialStart &&
          start >= initialStart &&
          start < initialEnd;
      TextStyle? segmentStyle;
      if (isSpoken) {
        segmentStyle = TextStyle(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        );
      } else if (isHighlighted) {
        segmentStyle = TextStyle(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        );
      } else if (isInitialReference) {
        segmentStyle = TextStyle(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
        );
      } else if (reference != null) {
        segmentStyle = TextStyle(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
          decorationThickness: 1.2,
          fontWeight: FontWeight.w600,
        );
      }
      TapGestureRecognizer? recognizer;
      if (reference != null) {
        recognizer = TapGestureRecognizer()
          ..onTap = () => widget.onScriptureTap(reference);
        _recognizers.add(recognizer);
      }
      spans.add(
        TextSpan(
          text: block.text.substring(start, end),
          style: segmentStyle,
          recognizer: recognizer,
          semanticsLabel: reference == null
              ? null
              : '${reference.rawText}, open Scripture passage',
        ),
      );
    }
    return Semantics(
      label: block.blockType == 'numbered_item'
          ? 'Point ${block.numberLabel}'
          : null,
      child: SelectableText.rich(
        TextSpan(style: style, children: spans),
        onTap: widget.onTap,
        onSelectionChanged: (selection, cause) {
          final prefixLength = prefix.length;
          widget.onSelectionChanged(
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
