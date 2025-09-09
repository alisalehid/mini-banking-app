import 'package:drift/drift.dart';
import '../local_transactions_db.dart';
import '../tables.dart';

part 'balance_dao.g.dart';

@DriftAccessor(tables: [Balances])
class BalanceDao extends DatabaseAccessor<LocalTransactionsDb> with _$BalanceDaoMixin {
  BalanceDao(LocalTransactionsDb db) : super(db);

  Future<int> getAmountCents() async {
    final row = await (select(balances)..limit(1)).getSingleOrNull();
    return row?.amountCents ?? 0;
  }

  Future<void> upsertAmountCents(int newAmount) async {
    final row = await (select(balances)..limit(1)).getSingleOrNull();
    if (row == null) {
      await into(balances).insert(
        BalancesCompanion(
          amountCents: Value(newAmount),
        ),
      );
    } else {
      await (update(balances)..where((tbl) => tbl.id.equals(row.id)))
          .write(BalancesCompanion(amountCents: Value(newAmount)));
    }
  }
}
