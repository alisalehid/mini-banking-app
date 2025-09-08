import 'package:go_router/go_router.dart';

import '../core/widgets/app_scaffold.dart';
import '../features/auth/presentation/bloc/login_cubit.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/settings/presentation/pages/setting_page.dart';
import '../features/transactions/presentation/pages/transactions_page.dart';
import '../features/transfer/presentation/pages/transfer_page.dart';
import 'go_router_refresh_stream.dart';

late final GoRouter appRouter;

GoRouter buildRouter(LoginCubit authCubit) {
  appRouter = GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, state) => const LoginPage(),
      ),

      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/transfer',
            builder: (_, state) => const TransferPage(),
          ),
          GoRoute(
            path: '/transactions',
            builder: (_, state) => const TransactionsPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (_, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authCubit.state.isValid;
      final loggingIn = state.uri.toString() == '/login';

      if (!isLoggedIn) {
        return loggingIn ? null : '/login';
      }

      if (isLoggedIn && loggingIn) {
        return '/dashboard';
      }

      return null;
    },
  );

  return appRouter;
}