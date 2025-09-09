import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final bool hasReachedMax;

  TransactionLoaded(this.transactions, {this.hasReachedMax = false});

  TransactionLoaded copyWith({
    List<Transaction>? transactions,
    bool? hasReachedMax,
  }) {
    return TransactionLoaded(
      transactions ?? this.transactions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [transactions, hasReachedMax];
}
class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
  @override
  List<Object?> get props => [message];
}
