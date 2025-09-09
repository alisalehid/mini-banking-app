import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/presentation/theme/app_colors.dart';

class MoneyTransferPage extends StatelessWidget {
  const MoneyTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text("Send Money"),
        backgroundColor: AppColors.background(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/dashboard');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,) ,
            Center(
              child: Text("Total Balance", style: TextStyle(fontSize: 18)),
            ) ,
            Center(
              child: Text("\$1200.0", style: TextStyle(fontSize: 48)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0xFFFF5F6D), // Red
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.transparent,
                      // no solid color
                      foregroundColor: AppColors.textColor(context),
                      // red text & icon
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {},
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
