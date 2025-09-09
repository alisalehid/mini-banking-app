import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.amount,
    required super.description,
    required super.date,
    required super.status,
    required super.account,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      account: json['account'],
    );
  }
}
