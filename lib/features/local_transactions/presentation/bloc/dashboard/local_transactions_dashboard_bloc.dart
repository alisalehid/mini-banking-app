import 'package:flutter_bloc/flutter_bloc.dart';
import 'local_transactions_dashboard_event.dart';
import 'local_transactions_dashboard_state.dart';
import '../../../domain/usecases/get_local_transactions_balance.dart';
import '../../../domain/usecases/get_local_transactions_recent_transactions.dart';

class LocalTransactionsDashboardBloc
    extends Bloc<LocalTransactionsDashboardEvent, LocalTransactionsDashboardState> {
  final GetLocalTransactionsBalance getBalance;
  final GetLocalTransactionsRecentTransactions getRecent;

  LocalTransactionsDashboardBloc({
    required this.getBalance,
    required this.getRecent,
  }) : super(LocalTransactionsDashboardState.initial()) {
    on<LocalTransactionsDashboardStarted>(_load);
    on<LocalTransactionsDashboardRefreshed>(_load);
  }

  Future<void> _load(LocalTransactionsDashboardEvent event,
      Emitter<LocalTransactionsDashboardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final balance = await getBalance();
      final txns = await getRecent(limit: 5);
      emit(state.copyWith(loading: false, balance: balance, transactions: txns));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
