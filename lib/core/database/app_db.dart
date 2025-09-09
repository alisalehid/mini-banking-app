import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'drift_tables.dart';

part 'app_db.g.dart';

// Drift Database
@DriftDatabase(tables: [BalanceTable, TransactionsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get current balance
  Future<double> getBalance() async {
    final balance = await select(balanceTable).getSingleOrNull();
    return balance?.amount ?? 0.0;
  }

  // Update balance
  Future<void> updateBalance(double newAmount) async {
    final exists = await select(balanceTable).getSingleOrNull();
    if (exists == null) {
      await into(balanceTable).insert(BalanceTableCompanion(amount: Value(newAmount)));
    } else {
      await (update(balanceTable)..where((tbl) => tbl.id.equals(exists.id)))
          .write(BalanceTableCompanion(amount: Value(newAmount)));
    }
  }

  // Get last N transactions
  Future<List<TransactionModel>> getLastTransactions({int limit = 5}) async {
    final results = await (select(transactionsTable)
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
      ..limit(limit))
        .get();
    return results
        .map((e) => TransactionModel(
      id: e.id,
      date: e.date,
      description: e.description,
      amount: e.amount,
    ))
        .toList();
  }

  // Add a transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await into(transactionsTable).insert(
      TransactionsTableCompanion.insert(
        date: transaction.date,
        description: transaction.description,
        amount: transaction.amount,
      ),
    );
  }
}

// Transaction model mapping for domain
class TransactionModel {
  final int? id;
  final DateTime date;
  final String description;
  final double amount;

  TransactionModel({this.id, required this.date, required this.description, required this.amount});
}

// Drift connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return SqfliteQueryExecutor(
      path: file.path,  // <-- named parameter now
      logStatements: true,
    );
  });
}

