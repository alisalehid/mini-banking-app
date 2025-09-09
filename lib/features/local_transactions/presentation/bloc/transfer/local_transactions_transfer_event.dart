import 'package:equatable/equatable.dart';

abstract class LocalTransactionsTransferEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalTransactionsTransferStarted extends LocalTransactionsTransferEvent {}

class LocalTransactionsBeneficiaryChanged extends LocalTransactionsTransferEvent {
  final String name;
  LocalTransactionsBeneficiaryChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class LocalTransactionsAccountChanged extends LocalTransactionsTransferEvent {
  final String accountNumber;
  LocalTransactionsAccountChanged(this.accountNumber);
  @override
  List<Object?> get props => [accountNumber];
}

class LocalTransactionsAmountChanged extends LocalTransactionsTransferEvent {
  final String amountText;
  LocalTransactionsAmountChanged(this.amountText);
  @override
  List<Object?> get props => [amountText];
}

class LocalTransactionsSubmitPressed extends LocalTransactionsTransferEvent {}
