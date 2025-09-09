import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
      create: (_) => sl<LocalTransactionsDashboardBloc>()
        ..add(LocalTransactionsDashboardStarted()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Dashboard')),
      body: BlocBuilder<LocalTransactionsDashboardBloc, LocalTransactionsDashboardState>(
        builder: (context, state) {
          if (state.loading && state.balance == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }
          final balanceCents = state.balance?.amountCents ?? 0;

          return RefreshIndicator(
            onRefresh: () async => context
                .read<LocalTransactionsDashboardBloc>()
                .add(LocalTransactionsDashboardRefreshed()),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Account Balance',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 8),
                        MoneyText(
                          cents: balanceCents,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Last 5 Local Transactions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ...state.transactions.map((t) => ListTile(
                  leading: Icon(
                    t.amountCents < 0 ? Icons.call_made : Icons.call_received,
                  ),
                  title: Text(t.description),
                  subtitle: Text(
                    // yyyy-MM-dd HH:mm
                    '${t.date.year}-${t.date.month.toString().padLeft(2, '0')}-${t.date.day.toString().padLeft(2, '0')} '
                        '${t.date.hour.toString().padLeft(2, '0')}:${t.date.minute.toString().padLeft(2, '0')}',
                  ),
                  trailing: MoneyText(
                    cents: t.amountCents,
                    style: TextStyle(
                      color: t.amountCents < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => context.go('/local/transfer'),
                  child: const Text('Send Money'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
