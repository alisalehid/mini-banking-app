import 'package:drift/drift.dart';
import '../local_transactions_db.dart';
import '../tables.dart';

part 'balance_dao.g.dart';

@DriftAccessor(tables: [Balances])
class BalanceDao extends DatabaseAccessor<LocalTransactionsDb> with _$BalanceDaoMixin {
  BalanceDao(LocalTransactionsDb db) : super(db);

  Future<int> getAmount() async {
    final row = await (select(balances)..limit(1)).getSingleOrNull();
    return row?.amount ?? 0;
  }

  Future<void> upsertAmount(int newAmount) async {
    final row = await (select(balances)..limit(1)).getSingleOrNull();
    if (row == null) {
      await into(balances).insert(
        BalancesCompanion(
          amount: Value(newAmount),
        ),
      );
    } else {
      await (update(balances)..where((tbl) => tbl.id.equals(row.id)))
          .write(BalancesCompanion(amount: Value(newAmount)));
    }
  }
}
