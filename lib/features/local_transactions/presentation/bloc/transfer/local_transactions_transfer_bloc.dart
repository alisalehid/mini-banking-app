import 'package:flutter_bloc/flutter_bloc.dart';
import 'local_transactions_transfer_event.dart';
import 'local_transactions_transfer_state.dart';
import '../../../domain/usecases/get_local_transactions_balance.dart';
import '../../../domain/usecases/send_local_transactions_money.dart';

class LocalTransactionsTransferBloc
    extends Bloc<LocalTransactionsTransferEvent, LocalTransactionsTransferState> {
  final GetLocalTransactionsBalance getBalance;
  final SendLocalTransactionsMoney sendMoney;
  final void Function()? onSuccessNavigateBack; // go_router action hook
  final void Function()? onSuccessRefreshDashboard; // optional refresh hook

  LocalTransactionsTransferBloc({
    required this.getBalance,
    required this.sendMoney,
    this.onSuccessNavigateBack,
    this.onSuccessRefreshDashboard,
  }) : super(LocalTransactionsTransferState.initial()) {
    on<LocalTransactionsTransferStarted>(_onStart);
    on<LocalTransactionsBeneficiaryChanged>(_onBeneficiary);
    on<LocalTransactionsAccountChanged>(_onAccount);
    on<LocalTransactionsAmountChanged>(_onAmount);
    on<LocalTransactionsSubmitPressed>(_onSubmit);
  }

  Future<void> _onStart(LocalTransactionsTransferStarted event,
      Emitter<LocalTransactionsTransferState> emit) async {
    final bal = await getBalance();
    emit(state.copyWith(currentBalanceCents: bal.amountCents));
  }

  void _onBeneficiary(LocalTransactionsBeneficiaryChanged e,
      Emitter<LocalTransactionsTransferState> emit) {
    final valid = _validateName(e.name);
    emit(state.copyWith(
      beneficiary: e.name,
      nameValid: valid,
      success: false,
      error: null,
    ));
    _revalidateAmount(emit);
  }

  void _onAccount(LocalTransactionsAccountChanged e,
      Emitter<LocalTransactionsTransferState> emit) {
    final valid = _validateAccount(e.accountNumber);
    emit(state.copyWith(
      accountNumber: e.accountNumber,
      accountValid: valid,
      success: false,
      error: null,
    ));
    _revalidateAmount(emit);
  }

  void _onAmount(LocalTransactionsAmountChanged e,
      Emitter<LocalTransactionsTransferState> emit) {
    emit(state.copyWith(
      amountText: e.amountText,
      success: false,
      error: null,
    ));
    _revalidateAmount(emit);
  }

  void _revalidateAmount(Emitter<LocalTransactionsTransferState> emit) {
    final cents = _parseAmountToCents(state.amountText);
    final syntaxOk = cents != null && cents > 0;
    final withinBalance = syntaxOk && cents! <= state.currentBalanceCents;
    emit(state.copyWith(amountValid: syntaxOk && withinBalance));
  }

  Future<void> _onSubmit(LocalTransactionsSubmitPressed event,
      Emitter<LocalTransactionsTransferState> emit) async {
    if (!state.isFormValid || state.submitting) return;
    emit(state.copyWith(submitting: true, error: null));
    try {
      final cents = _parseAmountToCents(state.amountText)!;

      await sendMoney(
        beneficiaryName: state.beneficiary.trim(),
        accountNumber: state.accountNumber.replaceAll(' ', ''),
        amountCents: cents,
      );

      emit(state.copyWith(submitting: false, success: true));
      onSuccessRefreshDashboard?.call();
      onSuccessNavigateBack?.call();
    } catch (e) {
      emit(state.copyWith(submitting: false, error: e.toString()));
    }
  }
}

/// ===== Validation helpers =====

bool _validateName(String v) {
  // 2–50 chars, only letters, spaces, dot, apostrophe, hyphen
  final re = RegExp(r"^[A-Za-z .'\-]{2,50}$");
  return re.hasMatch(v.trim());
}

bool _validateAccount(String v) {
  final digits = v.replaceAll(RegExp(r'\s+'), '');
  return RegExp(r'^\d{10,24}$').hasMatch(digits);
}

/// Parses a string with max 2 decimals to cents. Returns null on invalid.
int? _parseAmountToCents(String input) {
  final trimmed = input.trim();
  if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(trimmed)) return null;
  final parts = trimmed.split('.');
  final dollars = int.parse(parts[0]);
  final cents = parts.length == 2 ? int.parse((parts[1] + '00').substring(0, 2)) : 0;
  final total = dollars * 100 + cents;
  return total > 0 ? total : null;
}
