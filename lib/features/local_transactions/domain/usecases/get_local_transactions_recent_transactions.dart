import '../entities/local_transactions_transaction_entity.dart';
import '../repositories/local_transactions_repository.dart';

class GetLocalTransactionsRecentTransactions {
  final LocalTransactionsRepository repo;
  GetLocalTransactionsRecentTransactions(this.repo);

  Future<List<LocalTransactionsTransactionEntity>> call({int limit = 5}) {
    return repo.getRecentTransactions(limit: limit);
  }
}
