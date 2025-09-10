import '../../../domain/entities/dashboard_transaction.dart';
import '../../../domain/entities/local_transactions_balance_entity.dart';

class LocalTransactionsDashboardState {
  final bool loading;
  final LocalTransactionsBalanceEntity? balance;
  final List<DashboardTransaction> transactions;
  final String? error;

  LocalTransactionsDashboardState({
    required this.loading,
    required this.balance,
    required this.transactions,
    required this.error,
  });

  factory LocalTransactionsDashboardState.initial() {
    return LocalTransactionsDashboardState(
      loading: false,
      balance: null,
      transactions: [],
      error: null,
    );
  }

  LocalTransactionsDashboardState copyWith({
    bool? loading,
    LocalTransactionsBalanceEntity? balance,
    List<DashboardTransaction>? transactions,
    String? error,
  }) {
    return LocalTransactionsDashboardState(
      loading: loading ?? this.loading,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      error: error,
    );
  }
}
