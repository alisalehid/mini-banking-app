// lib/src/features/dashboard/presentation/bloc/dashboard_cubit.dart
import 'package:bloc/bloc.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  void selectTab(int index) => emit(index);
}
