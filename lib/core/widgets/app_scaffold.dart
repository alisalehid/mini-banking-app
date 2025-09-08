// lib/src/core/widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/presentation/providers/theme_notifier.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  static final List<_NavItem> _navItems = [
    _NavItem('/dashboard', Icons.home, 'Home'),
    _NavItem('/transfer', Icons.wallet, 'wallet'),
    _NavItem('/transactions', Icons.payment, 'Transactions'),
    _NavItem('/settings', Icons.settings, 'Settings'),
  ];

  int _locationToIndex(String location) {
    final index = _navItems.indexWhere((item) => location.startsWith(item.path));
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _locationToIndex(location);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background(context),
        currentIndex: selectedIndex,
        onTap: (index) {
          context.go(_navItems[index].path);
        },
        type: BottomNavigationBarType.fixed,
        items: _navItems
            .map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label,
        ))
            .toList(),
      ),
    );
  }
}

class _NavItem {
  final String path;
  final IconData icon;
  final String label;

  const _NavItem(this.path, this.icon, this.label);
}
