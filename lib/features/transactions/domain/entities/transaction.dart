class Transaction {
  final String id;
  final String amount;
  final String description;
  final DateTime date;
  final String status;
  final String account;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.account,
  });
}
