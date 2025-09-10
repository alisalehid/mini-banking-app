
abstract class TransactionRepository {
  Future<List<dynamic>> getTransactions(int page, int limit);

}
