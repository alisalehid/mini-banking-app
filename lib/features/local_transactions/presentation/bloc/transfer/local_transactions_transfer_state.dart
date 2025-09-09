import 'package:equatable/equatable.dart';

class LocalTransactionsTransferState extends Equatable {
  final String beneficiary;
  final String accountNumber;
  final String amountText;

  final bool nameValid;
  final bool accountValid;
  final bool amountValid; // syntactic + balance check combined

  final int currentBalanceCents;

  final bool submitting;
  final bool success;
  final String? error;

  bool get isFormValid => nameValid && accountValid && amountValid;

  const LocalTransactionsTransferState({
    required this.beneficiary,
    required this.accountNumber,
    required this.amountText,
    required this.nameValid,
    required this.accountValid,
    required this.amountValid,
    required this.currentBalanceCents,
    required this.submitting,
    required this.success,
    required this.error,
  });

  factory LocalTransactionsTransferState.initial() => const LocalTransactionsTransferState(
    beneficiary: '',
    accountNumber: '',
    amountText: '',
    nameValid: false,
    accountValid: false,
    amountValid: false,
    currentBalanceCents: 0,
    submitting: false,
    success: false,
    error: null,
  );

  LocalTransactionsTransferState copyWith({
    String? beneficiary,
    String? accountNumber,
    String? amountText,
    bool? nameValid,
    bool? accountValid,
    bool? amountValid,
    int? currentBalanceCents,
    bool? submitting,
    bool? success,
    String? error,
  }) {
    return LocalTransactionsTransferState(
      beneficiary: beneficiary ?? this.beneficiary,
      accountNumber: accountNumber ?? this.accountNumber,
      amountText: amountText ?? this.amountText,
      nameValid: nameValid ?? this.nameValid,
      accountValid: accountValid ?? this.accountValid,
      amountValid: amountValid ?? this.amountValid,
      currentBalanceCents: currentBalanceCents ?? this.currentBalanceCents,
      submitting: submitting ?? this.submitting,
      success: success ?? this.success,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    beneficiary,
    accountNumber,
    amountText,
    nameValid,
    accountValid,
    amountValid,
    currentBalanceCents,
    submitting,
    success,
    error,
  ];
}
