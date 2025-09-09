

import '../../../../core/database/app_db.dart';
import '../../../dashboard/data/datasources/dashboard_local_datasource.dart';

class SendMoneyUseCase {
  final DashboardLocalDataSource dataSource;

  SendMoneyUseCase(this.dataSource);

  Future<void> execute({required String beneficiary, required String account, required double amount}) async {
    final currentBalance = await dataSource.getBalance();
    if (currentBalance < amount) throw Exception('Insufficient balance');

    // Deduct balance
    await dataSource.database.updateBalance(currentBalance - amount);

    // Add transaction
    await dataSource.database.addTransaction(
      TransactionModel(
        date: DateTime.now(),
        description: 'Sent to $beneficiary ($account)',
        amount: -amount,
      ),
    );
  }
}
