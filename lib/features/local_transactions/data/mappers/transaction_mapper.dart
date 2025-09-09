import '../../domain/entities/local_transactions_transaction_entity.dart';
import '../../infrastructure/db/local_transactions_db.dart';

LocalTransactionsTransactionEntity mapLocalTxnRowToEntity(LocalTxn row) {
  return LocalTransactionsTransactionEntity(
    id: row.id,
    date: row.date,
    description: row.description,
    amountCents: row.amountCents,
  );
}
