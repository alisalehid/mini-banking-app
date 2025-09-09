import '../entities/local_transactions_balance_entity.dart';
import '../repositories/local_transactions_repository.dart';

class GetLocalTransactionsBalance {
  final LocalTransactionsRepository repo;
  GetLocalTransactionsBalance(this.repo);

  Future<LocalTransactionsBalanceEntity> call() => repo.getBalance();
}
