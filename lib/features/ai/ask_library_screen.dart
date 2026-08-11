import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';

class AskLibraryScreen extends ConsumerStatefulWidget {
  const AskLibraryScreen({super.key});

  @override
  ConsumerState<AskLibraryScreen> createState() => _AskLibraryScreenState();
}

class _AskLibraryScreenState extends ConsumerState<AskLibraryScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _enabled = false;
  bool _loading = false;
  AiAnswer? _answer;
  List<AiSource> _sources = const <AiSource>[];
  String? _error;

  @override
  void initState() {
    super.initState();
    ref.read(archiveRepositoryProvider).getValue('ai_enabled').then((value) {
      if (mounted) setState(() => _enabled = value == 'true');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final question = _controller.text.trim();
    if (!_enabled || question.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
      _answer = null;
    });
    try {
      final repository = ref.read(archiveRepositoryProvider);
      final hits = await repository.search(question, limit: 8);
      final sources = <AiSource>[];
      for (final hit in hits) {
        final blocks = await repository.getBlocks(hit.documentId);
        final block = blocks
            .where((item) => item.id == hit.blockId)
            .firstOrNull;
        if (block == null) continue;
        sources.add(
          AiSource(
            sourceId: block.id,
            collection: hit.collectionName,
            document: hit.documentTitle,
            blockLabel: hit.blockLabel,
            text: block.text.length > 1500
                ? block.text.substring(0, 1500)
                : block.text,
          ),
        );
      }
      final answer = await ref
          .read(aiRepositoryProvider)
          .ask(question, sources);
      if (mounted) {
        setState(() {
          _sources = sources;
          _answer = answer;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _error =
              'Ask the Library is temporarily unavailable. You can still search the archive.',
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask the Library')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              Icon(
                Icons.auto_awesome,
                size: 54,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'Answer from the archive only',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your question and up to eight locally retrieved archive passages are sent to the configured secure service. Notes, highlights, bookmarks, and history are never sent.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              SwitchListTile(
                value: _enabled,
                title: const Text('Enable Ask the Library'),
                subtitle: const Text(
                  'Requires an internet connection when a production AI endpoint is configured.',
                ),
                onChanged: (value) async {
                  await ref
                      .read(archiveRepositoryProvider)
                      .setValue('ai_enabled', value.toString());
                  setState(() => _enabled = value);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                enabled: _enabled && !_loading,
                maxLength: 1000,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'What does the downloaded archive say about…?',
                ),
              ),
              FilledButton.icon(
                onPressed: _enabled && !_loading ? _ask : null,
                icon: _loading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_outlined),
                label: const Text('Ask'),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              if (_answer != null) ...<Widget>[
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Archive-grounded response',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _answer!.answer,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (_answer!.citationIds.isNotEmpty) ...<Widget>[
                          const Divider(height: 30),
                          Text(
                            'Sources',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          for (final id in _answer!.citationIds)
                            Builder(
                              builder: (context) {
                                final source = _sources
                                    .where((item) => item.sourceId == id)
                                    .firstOrNull;
                                if (source == null) {
                                  return const SizedBox.shrink();
                                }
                                final documentId = id.split(':').first;
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.link),
                                  title: Text(source.document),
                                  subtitle: Text(source.blockLabel ?? id),
                                  onTap: () => context.push(
                                    '/document/$documentId?block=${Uri.encodeQueryComponent(id)}',
                                  ),
                                );
                              },
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
