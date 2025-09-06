// lib/src/app/router.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


import '../features/auth/presentation/bloc/auth_cubit.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/settings/presentation/pages/setting_page.dart';
import '../features/transactions/presentation/pages/transactions_page.dart';
import '../features/transfer/presentation/pages/transfer_page.dart';
import '../features/auth/presentation/pages/login.dart';

// A simple implementation of GoRouterRefreshStream
// This is a common solution if it's not provided by a package.
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

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
        builder: (_, state) =>  DashboardPage(),
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