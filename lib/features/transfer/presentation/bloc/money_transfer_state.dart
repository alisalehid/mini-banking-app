part of 'money_transfer_bloc.dart';

abstract class MoneyTransferState {}

class MoneyTransferInitial extends MoneyTransferState {}

class MoneyTransferSuccess extends MoneyTransferState {}

class MoneyTransferFailure extends MoneyTransferState {
  final String message;
  MoneyTransferFailure({required this.message});
}
