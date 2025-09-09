import 'package:bloc/bloc.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc(this.repository) : super(DashboardLoading()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      final balance = await repository.getBalance();
      final transactions = await repository.getTransactions(limit: 5);
      emit(DashboardLoaded(balance: balance, transactions: transactions));
    });
  }
}
