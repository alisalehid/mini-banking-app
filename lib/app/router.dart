import 'package:go_router/go_router.dart';
import 'package:mini_banking_app/features/settings/presentation/pages/setting_page.dart';
import '../core/widgets/app_scaffold.dart';
import '../features/auth/presentation/bloc/login_cubit.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/transactions/presentation/pages/transactions_page.dart';
import '../features/transfer/presentation/pages/transfer_page.dart';
import 'go_router_refresh_stream.dart';

GoRouter createRouter(LoginCubit authCubit) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardPage(),
          ),
          GoRoute(
            path: '/transfer',
            builder: (_, __) => const MoneyTransferPage(),
          ),
          GoRoute(
            path: '/transactions',
            builder: (_, __) => const TransactionPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authCubit.state.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn) {
        return isLoggingIn ? null : '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/dashboard';
      }
      return null;
    },

  );
}
