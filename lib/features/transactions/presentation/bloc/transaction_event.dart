import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {
  final int page;
  final int limit;

  LoadTransactions({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class LoadMoreTransactions extends TransactionEvent {}
