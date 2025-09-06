// lib/src/app/router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/bloc/auth_cubit.dart';
import '../features/auth/presentation/pages/login.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/settings/presentation/pages/setting_page.dart';
import '../features/transactions/presentation/pages/transactions_page.dart';
import '../features/transfer/presentation/pages/transfer_page.dart';
import 'go_router_refresh_stream.dart';


late final GoRouter appRouter;

GoRouter buildRouter(AuthCubit authCubit) {
  appRouter = GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, state) =>  LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/transfer',
        builder: (_, state) =>  TransferPage(),
      ),
      GoRoute(
        path: '/transactions',
        builder: (_, state) =>  TransactionsPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, state) =>  SettingsPage(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authCubit.state.isAuthenticated;
      final loggingIn = state.uri.toString() == '/login';

      if (!isLoggedIn) return loggingIn ? null : '/login';
      if (loggingIn) return '/dashboard';
      return null;
    },
  );

  return appRouter;
}
