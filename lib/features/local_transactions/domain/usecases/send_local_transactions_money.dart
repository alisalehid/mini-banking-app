import '../entities/local_transactions_balance_entity.dart';
import '../entities/local_transactions_transaction_entity.dart';
import '../repositories/local_transactions_repository.dart';

class SendLocalTransactionsMoney {
  final LocalTransactionsRepository repo;
  SendLocalTransactionsMoney(this.repo);

  Future<(LocalTransactionsBalanceEntity, LocalTransactionsTransactionEntity)> call({
    required String beneficiaryName,
    required String accountNumber,
    required int amountCents,
  }) {
    return repo.sendMoney(
      beneficiaryName: beneficiaryName,
      accountNumber: accountNumber,
      amountCents: amountCents,
    );
  }
}
