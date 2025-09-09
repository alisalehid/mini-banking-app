part of 'money_transfer_bloc.dart';

abstract class MoneyTransferEvent {}

class SendMoney extends MoneyTransferEvent {
  final String beneficiary;
  final String accountNumber;
  final double amount;

  SendMoney({required this.beneficiary, required this.accountNumber, required this.amount});
}
