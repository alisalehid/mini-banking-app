import 'package:flutter/material.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Center(child: Text("Home"),)
    );
  }
}
