class LocalTransactionsTransactionEntity {
  final int id;
  final DateTime date;
  final String description;
  final int amountCents;

  const LocalTransactionsTransactionEntity({
    required this.id,
    required this.date,
    required this.description,
    required this.amountCents,
  });
}
