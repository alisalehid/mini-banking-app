import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<Transaction>> call(int page, int limit) async {
    return await repository.getTransactions(page, limit);
  }
}
