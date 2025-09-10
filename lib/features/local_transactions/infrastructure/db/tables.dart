import 'package:drift/drift.dart';

class Balances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer().withDefault(const Constant(0))();
}

class LocalTxns extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  IntColumn get amount => integer()();
  TextColumn get status => text()();
  TextColumn get account => text()();
}
