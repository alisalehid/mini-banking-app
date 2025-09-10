import 'dashboard_transaction.dart';

class LocalTransactionsTransactionEntity {
  final int id;
  final DateTime date;
  final String description;
  final String amount;
  final String status ;
  final String account ;

  const LocalTransactionsTransactionEntity({
    required this.id,
    required this.date,
    required this.description,
    required this.amount,
    required this.status ,
    required this.account
  });
}

extension LocalEntityMapper on LocalTransactionsTransactionEntity {
  DashboardTransaction toDashboardTransaction() {
    return DashboardTransaction(
      id: id,
      date: date,
      description: description,
      amount: amount, // already String
      status: status,
      account: account,
    );
  }
}
