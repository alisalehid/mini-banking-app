import '../../../../core/database/app_db.dart';
import '../../domain/entities/transaction.dart';

class DashboardLocalDataSource {
  final AppDatabase database;

  DashboardLocalDataSource(this.database);

  Future<double> getBalance() => database.getBalance();

  Future<List<Transaction>> getTransactions({int limit = 5}) async {
    final result = await database.getLastTransactions(limit: limit);
    return result
        .map((e) => Transaction(date: e.date, description: e.description, amount: e.amount))
        .toList();
  }
}
