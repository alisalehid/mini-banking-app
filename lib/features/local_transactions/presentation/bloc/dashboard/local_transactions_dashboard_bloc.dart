import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../transactions/domain/usecases/get_transactions.dart';
import 'local_transactions_dashboard_event.dart';
import 'local_transactions_dashboard_state.dart';
import '../../../domain/usecases/get_local_transactions_balance.dart';
import '../../../domain/usecases/get_local_transactions_recent_transactions.dart';
import '../../../domain/entities/dashboard_transaction.dart';

class LocalTransactionsDashboardBloc
    extends Bloc<LocalTransactionsDashboardEvent, LocalTransactionsDashboardState> {
  final GetLocalTransactionsBalance getBalance;
  final GetLocalTransactionsRecentTransactions getRecentLocal;
  final GetTransactions getRemote;

  LocalTransactionsDashboardBloc({
    required this.getBalance,
    required this.getRecentLocal,
    required this.getRemote,
  }) : super(LocalTransactionsDashboardState.initial()) {
    on<LocalTransactionsDashboardStarted>(_load);
    on<LocalTransactionsDashboardRefreshed>(_load);
  }

  Future<void> _load(
      LocalTransactionsDashboardEvent event,
      Emitter<LocalTransactionsDashboardState> emit,
      ) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final balance = await getBalance();

      // map local tx
      final localTx = (await getRecentLocal(limit: 5)).map((e) => DashboardTransaction(
        id: e.id,
        date: e.date,
        amount: e.amount,
        status: e.status,
        account: e.account,
        description: e.description ?? "Local Transaction",
      ));

      // map remote tx
      final remoteTx = (await getRemote(1, 5)).map((e) => DashboardTransaction(
        id: parseNumber(e.id.toString()),
        date: e.date,
        amount: e.amount,
        status: e.status,
        account: e.account,
        description: e.description ?? "Remote Transaction",
      ));

      // merge and sort
      final allTx = [...localTx, ...remoteTx]..sort((a, b) => b.date.compareTo(a.date));

      emit(state.copyWith(
        loading: false,
        balance: balance,
        transactions: allTx,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  dynamic parseNumber(String value) {
    double parsed = double.parse(value);
    // If it has no decimal part, return int
    if (parsed % 1 == 0) {
      return parsed.toInt();
    } else {
      return parsed;
    }
  }

}
