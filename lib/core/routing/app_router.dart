import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_provider.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/health/presentation/health_timeline_screen.dart';

import '../../features/settings/presentation/settings_screen.dart';
import '../../features/pets/presentation/pets_list_screen.dart';
import '../../features/settings/presentation/event_types_list_screen.dart';
import 'presentation/main_layout_screen.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (previous, next) {
      notifyListeners();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);
    if (authState.isLoading || authState.hasError) return null;

    final isAuthenticated = authState.value ?? false;
    final isLoggingInOrRegistering =
        state.matchedLocation == '/login' || state.matchedLocation == '/register';

    if (!isAuthenticated && !isLoggingInOrRegistering) return '/login';
    if (isAuthenticated && isLoggingInOrRegistering) return '/home';

    return null;
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HealthTimelineScreen(),
              ),

            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'pets',
                    builder: (context, state) => const PetsListScreen(),
                  ),
                  GoRoute(
                    path: 'event-types',
                    builder: (context, state) => const EventTypesListScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
