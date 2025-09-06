// lib/src/features/dashboard/presentation/pages/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navigation_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavigationButton(
              label: 'Dashboard',
              icon: Icons.home,
              onTap: () => context.go('/dashboard'),
            ),
            const SizedBox(height: 16),
            NavigationButton(
              label: 'Transfer',
              icon: Icons.send,
              onTap: () => context.go('/transfer'),
            ),
            const SizedBox(height: 16),
            NavigationButton(
              label: 'Transactions',
              icon: Icons.list,
              onTap: () => context.go('/transactions'),
            ),
            const SizedBox(height: 16),
            NavigationButton(
              label: 'Settings',
              icon: Icons.settings,
              onTap: () => context.go('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}
