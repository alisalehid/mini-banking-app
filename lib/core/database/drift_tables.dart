import 'package:drift/drift.dart';

class BalanceTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
}

class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
}
