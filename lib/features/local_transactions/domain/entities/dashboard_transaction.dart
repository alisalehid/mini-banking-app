class DashboardTransaction {
  final int id;
  final DateTime date;
  final String description;
  final String amount;
  final String status ;
  final String account ;

  DashboardTransaction({
    required this.id,
    required this.date,
    required this.description,
    required this.amount,
    required this.status ,
    required this.account
  });
}
