import 'package:equatable/equatable.dart';
import '../../../domain/entities/local_transactions_balance_entity.dart';
import '../../../domain/entities/local_transactions_transaction_entity.dart';

class LocalTransactionsDashboardState extends Equatable {
  final bool loading;
  final LocalTransactionsBalanceEntity? balance;
  final List<LocalTransactionsTransactionEntity> transactions;
  final String? error;

  const LocalTransactionsDashboardState({
    required this.loading,
    required this.balance,
    required this.transactions,
    required this.error,
  });

  factory LocalTransactionsDashboardState.initial() =>
      const LocalTransactionsDashboardState(
        loading: false,
        balance: null,
        transactions: [],
        error: null,
      );

  LocalTransactionsDashboardState copyWith({
    bool? loading,
    LocalTransactionsBalanceEntity? balance,
    List<LocalTransactionsTransactionEntity>? transactions,
    String? error,
  }) {
    return LocalTransactionsDashboardState(
      loading: loading ?? this.loading,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, balance?.amountCents, transactions, error];
}
