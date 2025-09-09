import 'package:drift/drift.dart';
import '../local_transactions_db.dart';
import '../tables.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [LocalTxns])
class TransactionDao extends DatabaseAccessor<LocalTransactionsDb> with _$TransactionDaoMixin {
  TransactionDao(LocalTransactionsDb db) : super(db);

  Future<int> insertTransaction({
    required DateTime date,
    required String description,
    required int amountCents, // signed
  }) {
    return into(localTxns).insert(LocalTxnsCompanion.insert(
      date: date,
      description: description,
      amountCents: amountCents,
    ));
  }

  Future<List<LocalTxn>> getRecent({int limit = 5}) {
    return (select(localTxns)
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(limit))
        .get();
  }
}
