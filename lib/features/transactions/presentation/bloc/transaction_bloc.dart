import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import '../../domain/usecases/get_transactions.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;
  int currentPage = 1;
  final int limit = 10;

  TransactionBloc(this.getTransactions) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<LoadMoreTransactions>(_onLoadMoreTransactions);
  }

  Future<void> _onLoadTransactions(
      LoadTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactions(event.page, event.limit);
      emit(TransactionLoaded(transactions, hasReachedMax: transactions.length < event.limit));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onLoadMoreTransactions(
      LoadMoreTransactions event, Emitter<TransactionState> emit) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      if (currentState.hasReachedMax) return;

      currentPage++;
      try {
        final moreTransactions = await getTransactions(currentPage, limit);
        emit(moreTransactions.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : currentState.copyWith(
          transactions: currentState.transactions + moreTransactions,
        ));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    }
  }
}
