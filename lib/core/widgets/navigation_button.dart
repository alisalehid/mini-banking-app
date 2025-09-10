// lib/src/features/dashboard/presentation/widgets/navigation_button.dart
import 'package:flutter/material.dart';
import '../theme/presentation/theme/app_colors.dart';

class NavigationButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const NavigationButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
