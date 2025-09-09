import 'package:equatable/equatable.dart';

abstract class LocalTransactionsDashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalTransactionsDashboardStarted extends LocalTransactionsDashboardEvent {}

class LocalTransactionsDashboardRefreshed extends LocalTransactionsDashboardEvent {}
