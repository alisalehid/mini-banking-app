import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'local_transactions_db.g.dart';

@DriftDatabase(tables: [Balances, LocalTxns])
class LocalTransactionsDb extends _$LocalTransactionsDb {
  LocalTransactionsDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Seed $1200.00 on first run via onCreate.
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Seed default balance (120000 cents)
      await into(balances).insert(
        BalancesCompanion(
          amount: Value(12000),
        ),
      );
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'local_transactions.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
