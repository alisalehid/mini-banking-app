import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../../transactions/presentation/widgets/transaction_card.dart';
import '../../../transactions/presentation/widgets/transaction_placeholder.dart';
import '../../di/injection.dart';
import '../bloc/dashboard/local_transactions_dashboard_bloc.dart';
import '../bloc/dashboard/local_transactions_dashboard_event.dart';
import '../bloc/dashboard/local_transactions_dashboard_state.dart';
import '../widgets/money_text.dart';


class LocalTransactionsDashboardPage extends StatelessWidget {
  const LocalTransactionsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      sl<LocalTransactionsDashboardBloc>()
        ..add(LocalTransactionsDashboardStarted()),
      child: const _DashboardView(),
    );
  }
}

dynamic parseNumber(String value) {
  double parsed = double.parse(value);
  // If it has no decimal part, return int
  if (parsed % 1 == 0) {
    return parsed.toInt();
  } else {
    return parsed;
  }
}


class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocalTransactionsDashboardBloc,
          LocalTransactionsDashboardState>(
        builder: (context, state) {
          // shimmer loading
          if (state.loading && state.balance == null) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (_, __) => const TransactionPlaceholder(),
            );
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          final balanceCents = state.balance?.amount ?? 0;

          dynamic parseNumber(String value) {
            double parsed = double.parse(value);
            // If it has no decimal part, return int
            if (parsed % 1 == 0) {
              return parsed.toInt();
            } else {
              return parsed;
            }
          }
          return RefreshIndicator(
            onRefresh: () async => context
                .read<LocalTransactionsDashboardBloc>()
                .add(LocalTransactionsDashboardRefreshed()),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 80),

                // Balance Card
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
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        MoneyText(
                          cents: parseNumber(balanceCents.toString()),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '7853  XXXX  XXXX  XXXX',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/visa.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Quick Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _QuickActionButton(
                      icon: 'assets/images/send.png',
                      label: 'Send\nMoney',
                      onTap: () => context.go('/local/transfer'),
                    ),
                    _QuickActionButton(
                      icon: 'assets/images/scan.png',
                      label: 'Scan\nQR Code',
                      onTap: () {
                        // TODO: implement scan action
                      },
                    ),
                    _QuickActionButton(
                      icon: 'assets/images/bill.png',
                      label: 'Pay\nBill',
                      onTap: () {
                        // TODO: implement bill action
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Recent Transactions
                const Text(
                  "Recent Transactions",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                if (state.loading && state.transactions.isEmpty)
                // shimmer list when refreshing
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (_, __) => const TransactionPlaceholder(),
                  )
                else if (state.transactions.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text("No transactions found"),
                    ),
                  )
                else
                  Column(
                    children: state.transactions
                        .map((t) => TransactionCard(transaction: t))
                        .toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Quick Action Button
class _QuickActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Card(
            color: AppColors.cardBackground(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                icon,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                color: AppColors.textColor(context),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }




}
