import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(readerPreferencesProvider);
    final collections = ref.watch(collectionsProvider).value ?? const [];
    final storage = ref.watch(storageSummaryProvider).value;
    final storagePath = ref.watch(storagePathProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const _SectionTitle('Appearance'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SegmentedButton<ReaderPalette>(
                segments: const <ButtonSegment<ReaderPalette>>[
                  ButtonSegment(
                    value: ReaderPalette.light,
                    label: Text('Light'),
                    icon: Icon(Icons.light_mode_outlined),
                  ),
                  ButtonSegment(
                    value: ReaderPalette.dark,
                    label: Text('Dark'),
                    icon: Icon(Icons.dark_mode_outlined),
                  ),
                  ButtonSegment(
                    value: ReaderPalette.amoled,
                    label: Text('AMOLED'),
                    icon: Icon(Icons.contrast),
                  ),
                ],
                selected: <ReaderPalette>{preferences.palette},
                onSelectionChanged: (value) => ref
                    .read(readerPreferencesProvider.notifier)
                    .update(preferences.copyWith(palette: value.first)),
              ),
            ),
          ),
          const _SectionTitle('Reading'),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.folder_outlined),
                  title: const Text('Download location'),
                  subtitle: SelectableText(storagePath ?? 'Loading…'),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Font size'),
                  trailing: Text(preferences.fontSize.round().toString()),
                ),
                Slider(
                  value: preferences.fontSize,
                  min: 14,
                  max: 32,
                  divisions: 18,
                  onChanged: (value) => ref
                      .read(readerPreferencesProvider.notifier)
                      .update(preferences.copyWith(fontSize: value)),
                ),
              ],
            ),
          ),
          const _SectionTitle('Downloads & Storage'),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.text_snippet_outlined),
                  title: const Text('Text Collections'),
                  subtitle: Text(
                    '${storage?.byCollection.length ?? 0} downloaded',
                  ),
                  trailing: Text(_formatBytes(storage?.textBytes ?? 0)),
                ),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf_outlined),
                  title: const Text('PDFs'),
                  subtitle: const Text('Managed per document'),
                  trailing: Text(_formatBytes(storage?.cleanPdfBytes ?? 0)),
                ),
                ListTile(
                  leading: const Icon(Icons.document_scanner_outlined),
                  title: const Text('Original Scans'),
                  subtitle: const Text('Never downloaded automatically'),
                  trailing: Text(_formatBytes(storage?.originalScanBytes ?? 0)),
                ),
                ListTile(
                  leading: const Icon(Icons.headphones_outlined),
                  title: const Text('Audio'),
                  subtitle: const Text('Downloaded for offline playback'),
                  trailing: Text(_formatBytes(storage?.audioBytes ?? 0)),
                ),
                if ((storage?.otherAssetBytes ?? 0) > 0)
                  ListTile(
                    leading: const Icon(Icons.attach_file),
                    title: const Text('Other assets'),
                    trailing: Text(_formatBytes(storage!.otherAssetBytes)),
                  ),
                if (storage != null)
                  for (final collection in collections.where(
                    (item) => storage.byCollection.containsKey(item.id),
                  ))
                    ListTile(
                      dense: true,
                      title: Text(collection.name),
                      trailing: Text(
                        _formatBytes(storage.byCollection[collection.id]!),
                      ),
                    ),
              ],
            ),
          ),
          const _SectionTitle('Personal data'),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
              title: const Text('Delete personal study data'),
              subtitle: const Text(
                'Deletes bookmarks, highlights, notes, and reading history. Downloaded archive content is kept.',
              ),
              onTap: () => _deletePersonalData(context, ref),
            ),
          ),
          const _SectionTitle('AI'),
          const Card(
            child: ListTile(
              leading: Icon(Icons.auto_awesome),
              title: Text('Ask the Library'),
              subtitle: Text(
                'Disabled by default; sends only your question and retrieved archive excerpts.',
              ),
            ),
          ),
          const _SectionTitle('About'),
          Card(
            child: Column(
              children: const <Widget>[
                ListTile(
                  title: Text('The Prophetic Archive'),
                  subtitle: Text('The Capstone Digital Library'),
                ),
                ListTile(title: Text('App version'), trailing: Text('1.0.0')),
                ListTile(
                  title: Text('Content source'),
                  subtitle: Text('Oshione2002/the-prophetic-archive-content'),
                ),
                ListTile(
                  title: Text('Privacy'),
                  subtitle: Text(
                    'No account required. Study data stays on this device.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePersonalData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete personal study data?'),
        content: const Text(
          'This cannot be undone. Your downloaded archive collections and PDFs will not be removed.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(archiveRepositoryProvider).deletePersonalStudyData();
    ref
      ..invalidate(bookmarksProvider)
      ..invalidate(highlightsProvider)
      ..invalidate(notesProvider)
      ..invalidate(readingHistoryProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Personal study data was deleted.')),
      );
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 22, 4, 8),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

String _formatBytes(int bytes) => bytes < 1024 * 1024
    ? '${(bytes / 1024).toStringAsFixed(0)} KB'
    : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
