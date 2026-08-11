import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({this.section, super.key});

  final String? section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialIndex = switch (section) {
      'highlights' => 1,
      'notes' => 2,
      'history' => 3,
      _ => 0,
    };
    return DefaultTabController(
      key: ValueKey<int>(initialIndex),
      length: 4,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Study'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                tooltip: 'Settings',
                onPressed: () => context.push('/settings'),
                icon: const Icon(Icons.settings_outlined),
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'Bookmarks'),
              Tab(text: 'Highlights'),
              Tab(text: 'Notes'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _BookmarksTab(ref: ref),
            _HighlightsTab(ref: ref),
            _NotesTab(ref: ref),
            _HistoryTab(ref: ref),
          ],
        ),
      ),
    );
  }
}

class _BookmarksTab extends StatelessWidget {
  const _BookmarksTab({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) => ref
      .watch(bookmarksProvider)
      .when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (items) => items.isEmpty
            ? const _StudyEmpty(
                icon: Icons.bookmark_outline,
                text: 'Bookmarks will appear here.',
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map(
                      (item) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.bookmark),
                          title: Text(item.documentTitle),
                          subtitle: Text(item.label ?? 'Document bookmark'),
                          onTap: () => context.push(
                            '/document/${item.documentId}${item.blockId == null ? '' : '?block=${Uri.encodeQueryComponent(item.blockId!)}'}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      );
}

class _HighlightsTab extends StatelessWidget {
  const _HighlightsTab({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) => ref
      .watch(highlightsProvider)
      .when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (items) => items.isEmpty
            ? const _StudyEmpty(
                icon: Icons.border_color_outlined,
                text: 'Highlights will appear here.',
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map(
                      (item) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.border_color_outlined),
                          title: Text(item.selectedText),
                          subtitle: Text(item.blockId),
                          onTap: () => context.push(
                            '/document/${item.documentId}?block=${Uri.encodeQueryComponent(item.blockId)}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      );
}

class _NotesTab extends StatelessWidget {
  const _NotesTab({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) => ref
      .watch(notesProvider)
      .when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (items) => items.isEmpty
            ? const _StudyEmpty(
                icon: Icons.notes_outlined,
                text: 'Private notes will appear here.',
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map(
                      (item) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.note_outlined),
                          title: Text(item.documentTitle),
                          subtitle: Text(item.body),
                          onTap: () => context.push(
                            '/document/${item.documentId}${item.blockId == null ? '' : '?block=${Uri.encodeQueryComponent(item.blockId!)}'}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      );
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) => ref
      .watch(readingHistoryProvider)
      .when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (items) => items.isEmpty
            ? const _StudyEmpty(
                icon: Icons.history,
                text: 'Reading history will appear here.',
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map(
                      (item) => Card(
                        child: ListTile(
                          leading: CircularProgressIndicator(
                            value: item.percentage,
                          ),
                          title: Text(item.documentTitle),
                          subtitle: Text(
                            '${(item.percentage * 100).round()}% read',
                          ),
                          onTap: () => context.push(
                            '/document/${item.documentId}${item.lastBlockId == null ? '' : '?block=${Uri.encodeQueryComponent(item.lastBlockId!)}'}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      );
}

class _StudyEmpty extends StatelessWidget {
  const _StudyEmpty({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 52),
        const SizedBox(height: 14),
        Text(text),
      ],
    ),
  );
}
