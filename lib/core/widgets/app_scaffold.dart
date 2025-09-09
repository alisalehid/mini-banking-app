import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/presentation/providers/theme_notifier.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
   AppScaffold({super.key, required this.child});

  static final List<_NavItem> _navItems = [
    _NavItem('/dashboard', Icons.home, 'Home'),
    _NavItem('/transactions', Icons.payment, 'Transactions'),
    _NavItem('/about', Icons.info_outline_rounded, 'About us'),
    _NavItem('/settings', Icons.settings, 'Settings'),
  ];

  int _locationToIndex(String location) {
    final index = _navItems.indexWhere((item) => location.startsWith(item.path));
    return index == -1 ? 0 : index;
  }

  // List of routes where the BottomNavigationBar should be hidden
  final List<String> _hiddenNavPaths = [
    '/transfer',
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _locationToIndex(location);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final shouldShowNav = !_hiddenNavPaths.contains(GoRouterState.of(context).matchedLocation);

    return Scaffold(
      body: child,
      bottomNavigationBar: shouldShowNav
          ? BottomNavigationBar(
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
      )
          : null, // Return null to hide the BottomNavigationBar
    );
  }
}

class _NavItem {
  final String path;
  final IconData icon;
  final String label;

  const _NavItem(this.path, this.icon, this.label);
}
