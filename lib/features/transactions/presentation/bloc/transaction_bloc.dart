import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_banking_app/features/local_transactions/domain/entities/local_transactions_transaction_entity.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../data/models/transaction_model.dart';


class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;

  TransactionBloc(this.getTransactions) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
      LoadTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final dashboardTransactions = await getTransactions(event.page, event.limit);

      emit(TransactionLoaded(dashboardTransactions)); // Already DashboardTransaction
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
