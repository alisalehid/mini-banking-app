import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../../../core/theme/presentation/providers/theme_notifier.dart';

class TransactionsPage extends StatefulWidget {

  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);


    return Scaffold(
      backgroundColor: AppColors.background(context),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// User Profile Card
            ///
            SizedBox(height: 100,),
            Card(
              color: AppColors.cardBackground(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: const Text(
                  "John sample",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("User account"),
              ),
            ),
            const SizedBox(height: 16),



            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
