import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/bookmarks/presentation/pages/bookmarks_page.dart';
import '../../features/exams/presentation/pages/exam_page.dart';
import '../../features/questions/presentation/pages/questions_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/simulations/presentation/pages/simulations_page.dart';
import '../../features/statistics/presentation/pages/statistics_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/questions',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(path: '/questions', builder: (_, __) => const QuestionsPage()),
          GoRoute(path: '/exam', builder: (_, __) => const ExamPage()),
          GoRoute(path: '/bookmarks', builder: (_, __) => const BookmarksPage()),
          GoRoute(path: '/statistics', builder: (_, __) => const StatisticsPage()),
          GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
          GoRoute(path: '/simulations', builder: (_, __) => const SimulationsPage()),
        ],
      ),
    ],
  );
});

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    '/questions',
    '/exam',
    '/bookmarks',
    '/statistics',
    '/settings',
    '/simulations',
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final index = _tabs.indexWhere((e) => location.startsWith(e)).clamp(0, _tabs.length - 1);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Questions'),
          NavigationDestination(icon: Icon(Icons.quiz), label: 'Exam'),
          NavigationDestination(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Statistics'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
          NavigationDestination(icon: Icon(Icons.traffic), label: 'Simulations'),
        ],
        onDestinationSelected: (value) => context.go(_tabs[value]),
      ),
    );
  }
}
