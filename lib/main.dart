import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_banking_app/features/auth/presentation/pages/login.dart';
import 'package:mini_banking_app/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  GoRouter get _router => GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mini Banking App',
      routerConfig: _router,
    );
  }
}

