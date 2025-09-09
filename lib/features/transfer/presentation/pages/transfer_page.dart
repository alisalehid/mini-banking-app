import 'package:flutter/material.dart';

import '../../../../core/theme/presentation/theme/app_colors.dart';
class TransferPage extends StatelessWidget {

  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: AppColors.background(context),
        body: const Center(
          child: Text(
            "transfer",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

    );
  }
}