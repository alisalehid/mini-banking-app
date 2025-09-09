import '../entities/transaction.dart';

abstract class DashboardRepository {
  Future<double> getBalance();
  Future<List<Transaction>> getTransactions({int limit = 5});
}
