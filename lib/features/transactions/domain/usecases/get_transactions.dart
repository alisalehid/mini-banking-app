import '../../../local_transactions/domain/entities/dashboard_transaction.dart';
import '../repositories/transaction_repository.dart';

import '../../data/models/transaction_model.dart';
import '../../../local_transactions/domain/entities/local_transactions_transaction_entity.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<DashboardTransaction>> call(int page, int limit) async {
    final transactions = await repository.getTransactions(page, limit);

    return transactions.map((tx) {
      if (tx is TransactionModel) {
        return tx.toDashboardTransaction();
      } else if (tx is LocalTransactionsTransactionEntity) {
        return tx.toDashboardTransaction();
      } else {
        throw Exception("Unknown transaction type: ${tx.runtimeType}");
      }
    }).toList();
  }
}
