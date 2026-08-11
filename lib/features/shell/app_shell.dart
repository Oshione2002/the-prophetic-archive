import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _railExpanded = true;

  static const destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.local_library_outlined),
      selectedIcon: Icon(Icons.local_library),
      label: 'Library',
    ),
    NavigationDestination(
      icon: Icon(Icons.explore_outlined),
      selectedIcon: Icon(Icons.explore),
      label: 'Explore',
    ),
    NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
    NavigationDestination(
      icon: Icon(Icons.bookmarks_outlined),
      selectedIcon: Icon(Icons.bookmarks),
      label: 'Study',
    ),
  ];

  void _select(int index) => widget.navigationShell.goBranch(
    index,
    initialLocation: index == widget.navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () =>
            context.go('/search'),
        const SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true): () {
          if (context.canPop()) context.pop();
        },
      },
      child: Focus(
        autofocus: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 800) {
              final canExpand = constraints.maxWidth >= 1000;
              final extended = canExpand && _railExpanded;
              return Scaffold(
                body: Row(
                  children: <Widget>[
                    SafeArea(
                      child: NavigationRail(
                        extended: extended,
                        selectedIndex: widget.navigationShell.currentIndex,
                        onDestinationSelected: _select,
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Icon(
                            Icons.auto_stories_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 34,
                          ),
                        ),
                        trailing: canExpand
                            ? Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: IconButton(
                                      tooltip: extended
                                          ? 'Collapse navigation'
                                          : 'Expand navigation',
                                      onPressed: () => setState(
                                        () => _railExpanded = !_railExpanded,
                                      ),
                                      icon: Icon(
                                        extended
                                            ? Icons.chevron_left
                                            : Icons.chevron_right,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        destinations: destinations
                            .map(
                              (item) => NavigationRailDestination(
                                icon: item.icon,
                                selectedIcon: item.selectedIcon,
                                label: Text(item.label),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: widget.navigationShell),
                  ],
                ),
              );
            }
            return Scaffold(
              body: widget.navigationShell,
              bottomNavigationBar: NavigationBar(
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: _select,
                destinations: destinations,
              ),
            );
          },
        ),
      ),
    );
  }
}
