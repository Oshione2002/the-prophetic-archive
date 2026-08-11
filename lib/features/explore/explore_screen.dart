import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({this.section, super.key});

  final String? section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialIndex = switch (section) {
      'topics' => 1,
      'timeline' => 2,
      _ => 0,
    };
    return DefaultTabController(
      key: ValueKey<int>(initialIndex),
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explore'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'Scripture'),
              Tab(icon: Icon(Icons.sell_outlined), text: 'Topics'),
              Tab(icon: Icon(Icons.timeline), text: 'Timeline'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ref
                .watch(scriptureReferencesProvider)
                .when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('$error')),
                  data: (items) => items.isEmpty
                      ? const _ExploreEmpty(
                          text:
                              'No curated Bible references are available in downloaded collections.',
                        )
                      : ListView(
                          padding: const EdgeInsets.all(16),
                          children: items
                              .map(
                                (item) => Card(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.menu_book_outlined,
                                    ),
                                    title: Text(item.canonicalReference),
                                    subtitle: Text(
                                      '${item.book} • Chapter ${item.chapter}',
                                    ),
                                    onTap: () => context.push(
                                      '/document/${item.documentId}?block=${Uri.encodeQueryComponent(item.blockId)}',
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
            ref
                .watch(topicsProvider)
                .when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('$error')),
                  data: (items) => items.isEmpty
                      ? const _ExploreEmpty(
                          text:
                              'No curated topics are available in downloaded collections.',
                        )
                      : ListView(
                          padding: const EdgeInsets.all(16),
                          children: items
                              .map(
                                (topic) => Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.sell_outlined),
                                    title: Text(topic),
                                    subtitle: const Text(
                                      'Curated archive metadata',
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
            ref
                .watch(timelineProvider)
                .when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('$error')),
                  data: (items) => items.isEmpty
                      ? const _ExploreEmpty(
                          text:
                              'No publication dates are available in downloaded collections.',
                        )
                      : ListView(
                          padding: const EdgeInsets.all(16),
                          children: items
                              .map(
                                (item) => Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.event_outlined),
                                    title: Text(item.documentTitle),
                                    subtitle: Text(
                                      '${item.date} • ${item.dateType} date',
                                    ),
                                    onTap: () => context.push(
                                      '/document/${item.documentId}',
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
          ],
        ),
      ),
    );
  }
}

class _ExploreEmpty extends StatelessWidget {
  const _ExploreEmpty({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Text(text, textAlign: TextAlign.center),
    ),
  );
}
