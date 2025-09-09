import 'package:bloc/bloc.dart';
import '../../domain/usecases/send_money_usecase.dart';

part 'money_transfer_event.dart';
part 'money_transfer_state.dart';

class MoneyTransferBloc extends Bloc<MoneyTransferEvent, MoneyTransferState> {
  final SendMoneyUseCase sendMoneyUseCase;

  MoneyTransferBloc(this.sendMoneyUseCase) : super(MoneyTransferInitial()) {
    on<SendMoney>((event, emit) async {
      try {
        await sendMoneyUseCase.execute(
          beneficiary: event.beneficiary,
          account: event.accountNumber,
          amount: event.amount,
        );
        emit(MoneyTransferSuccess());
      } catch (e) {
        emit(MoneyTransferFailure(message: e.toString()));
      }
    });
  }
}
