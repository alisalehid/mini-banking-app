import '../entities/local_transactions_balance_entity.dart';
import '../entities/local_transactions_transaction_entity.dart';

abstract class LocalTransactionsRepository {
  Future<LocalTransactionsBalanceEntity> getBalance();
  Future<List<LocalTransactionsTransactionEntity>> getRecentTransactions({int limit = 5});

  /// Deducts [amountCents] from balance and inserts a negative transaction.
  Future<(LocalTransactionsBalanceEntity, LocalTransactionsTransactionEntity)> sendMoney({
    required String beneficiaryName,
    required String accountNumber,
    required int amountCents,
  });
}
