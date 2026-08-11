import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

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

  void _select(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
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
              return Scaffold(
                body: Row(
                  children: <Widget>[
                    SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 1150,
                        selectedIndex: navigationShell.currentIndex,
                        onDestinationSelected: _select,
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Icon(
                            Icons.auto_stories_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 34,
                          ),
                        ),
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
                    Expanded(child: navigationShell),
                  ],
                ),
              );
            }
            return Scaffold(
              body: navigationShell,
              bottomNavigationBar: NavigationBar(
                selectedIndex: navigationShell.currentIndex,
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
