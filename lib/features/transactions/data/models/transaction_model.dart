import '../../../local_transactions/domain/entities/dashboard_transaction.dart';
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
      amount: json['amount'].toString(),
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      account: json['account'],
    );
  }

  /// Convert this model into a DashboardTransaction
  DashboardTransaction toDashboardTransaction() {
    String amountStr;
    if (parseNumber(amount) % 1 == 0) {
      // Whole number → no decimal places
      amountStr = parseNumber(amount).toInt().toString();
    } else {
      // Keep decimals
      amountStr = amount.toString();
    }

    return DashboardTransaction(
      id: parseNumber(id) ,
      date: date,
      description: description,
      amount: amountStr,
      status: status,
      account: account,
    );
  }


  dynamic parseNumber(String value) {
    double parsed = double.parse(value);
    // If it has no decimal part, return int
    if (parsed % 1 == 0) {
      return parsed.toInt();
    } else {
      return parsed;
    }
  }

}
