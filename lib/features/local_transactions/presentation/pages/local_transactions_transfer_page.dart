import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../di/injection.dart';
import '../bloc/transfer/local_transactions_transfer_bloc.dart';
import '../bloc/transfer/local_transactions_transfer_event.dart';
import '../bloc/transfer/local_transactions_transfer_state.dart';
import '../widgets/validated_text_field.dart';
import '../widgets/money_text.dart';
import '../bloc/dashboard/local_transactions_dashboard_bloc.dart';
import '../bloc/dashboard/local_transactions_dashboard_event.dart';

class LocalTransactionsTransferPage extends StatelessWidget {
  const LocalTransactionsTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Transfer BLoC
        BlocProvider(
          create: (_) => sl<LocalTransactionsTransferBloc>()
            ..add(LocalTransactionsTransferStarted()),
        ),
        // Dashboard BLoC is optional here (to refresh on success if page exists above in the tree).
        // If your app hosts dashboard elsewhere, remove this extra provider and rely on router-level refresh.
      ],
      child: const _TransferView(),
    );
  }
}

class _TransferView extends StatelessWidget {
  const _TransferView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money (Local)')),
      body: BlocConsumer<LocalTransactionsTransferBloc, LocalTransactionsTransferState>(
        listenWhen: (prev, curr) => prev.success != curr.success || prev.error != curr.error,
        listener: (context, state) {
          if (state.success) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Transfer Successful'),
                content: const Text('The money has been sent and saved locally.'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(), // close dialog
                    child: const Text('OK'),
                  ),
                ],
              ),
            ).then((_) {
              // Navigate back to dashboard after confirmation
              context.go('/local/dashboard');
              // If dashboard bloc is mounted somewhere, trigger refresh:
              context.read<LocalTransactionsDashboardBloc?>()
                  ?.add(LocalTransactionsDashboardRefreshed());
            });
          } else if (state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          final bloc = context.read<LocalTransactionsTransferBloc>();
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Current Balance: ',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    MoneyText(cents: state.currentBalanceCents),
                  ],
                ),
                const SizedBox(height: 16),
                ValidatedTextField(
                  label: 'Beneficiary Name',
                  hint: "e.g. Jane O'Connor",
                  onChanged: (v) => bloc.add(LocalTransactionsBeneficiaryChanged(v)),
                  errorText: state.beneficiary.isEmpty || state.nameValid
                      ? null
                      : "2–50 letters, spaces, . ' - only",
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                ValidatedTextField(
                  label: 'Account Number',
                  hint: '10–24 digits',
                  keyboardType: TextInputType.number,
                  onChanged: (v) => bloc.add(LocalTransactionsAccountChanged(v)),
                  errorText: state.accountNumber.isEmpty || state.accountValid
                      ? null
                      : 'Enter 10–24 digits only',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                ValidatedTextField(
                  label: 'Amount',
                  hint: 'e.g. 25.00',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) => bloc.add(LocalTransactionsAmountChanged(v)),
                  errorText: () {
                    if (state.amountText.isEmpty) return null;
                    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(state.amountText)) {
                      return 'Positive number, max 2 decimals';
                    }
                    // Check against balance
                    return state.amountValid ? null : 'Amount must be ≤ current balance';
                  }(),
                  textInputAction: TextInputAction.done,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isFormValid && !state.submitting
                        ? () => bloc.add(LocalTransactionsSubmitPressed())
                        : null,
                    child: state.submitting
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Send'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
