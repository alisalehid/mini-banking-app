import 'package:drift/drift.dart';

class Balances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amountCents => integer().withDefault(const Constant(0))();
}

class LocalTxns extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  IntColumn get amountCents => integer()();
}
