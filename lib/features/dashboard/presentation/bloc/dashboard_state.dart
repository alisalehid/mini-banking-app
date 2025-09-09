part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final double balance;
  final List<Transaction> transactions;

  DashboardLoaded({required this.balance, required this.transactions});
}
