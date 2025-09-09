import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../../transactions/presentation/bloc/transaction_bloc.dart';
import '../../../transactions/presentation/bloc/transaction_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Fetch transactions when the page is loaded
    // context.read<TransactionBloc>().add(FetchTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '\$1200.00',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 30),

                    Text(
                      '7853  XXXX  XXXX  XXXX',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/visa.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Card(
                      color: AppColors.cardBackground(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/images/send.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          color: AppColors.textColor(context),
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("send\nmoney", textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  children: [
                    Card(
                      color: AppColors.cardBackground(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/images/scan.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          color: AppColors.textColor(context),
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Scan\nQR code", textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  children: [
                    Card(
                      color: AppColors.cardBackground(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/images/bill.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          color: AppColors.textColor(context),
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Pay\nBill", textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TransactionLoaded) {
                  if (state.transactions.isEmpty) {
                    return const Center(child: Text("No transactions yet."));
                  }
                  // return ListView.separated(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: state.transactions.length,
                  //   separatorBuilder: (_, __) => const SizedBox(height: 8),
                  //   itemBuilder: (context, index) {
                  //     final t = state.transactions[index];
                  //     return ListTile(
                  //       leading: Icon(
                  //         t.status == "withdrawal"
                  //             ? Icons.arrow_upward
                  //             : Icons.arrow_downward,
                  //         color: t.status == "withdrawal" ? Colors.red : Colors.green,
                  //       ),
                  //       title: Text(t.title),
                  //       subtitle: Text(t.date),
                  //       trailing: Text(
                  //         "\$${t.amount.toStringAsFixed(2)}",
                  //         style: TextStyle(
                  //           color: t.status == "withdrawal" ? Colors.red : Colors.green,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                } else if (state is TransactionError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
