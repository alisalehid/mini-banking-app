import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../../../core/widgets/rounded_loading_button.dart';
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
        BlocProvider(
          create: (_) => sl<LocalTransactionsTransferBloc>()
            ..add(LocalTransactionsTransferStarted()),
        ),
      ],
      child: const _TransferView(),
    );
  }
}

class _TransferView extends StatefulWidget {
  const _TransferView({super.key});

  @override
  State<_TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<_TransferView> {
  final _loadingController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        title: const Text('Send Money'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/local/dashboard');
            context.read<LocalTransactionsDashboardBloc?>()?.add(
              LocalTransactionsDashboardRefreshed(),
            );
          },
        ),
      ),
      body: BlocConsumer<LocalTransactionsTransferBloc,
          LocalTransactionsTransferState>(
        listenWhen: (prev, curr) =>
        prev.success != curr.success || prev.error != curr.error,
        listener: (context, state) {
          if (state.success) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Transfer Successful'),
                content: const Text(
                  'The money has been sent and saved locally.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child:  Text('OK' , style: TextStyle(color: AppColors.textColor(context)),),
                  ),
                ],
              ),
            ).then((_) {
              context.go('/local/dashboard');
              context.read<LocalTransactionsDashboardBloc?>()?.add(
                LocalTransactionsDashboardRefreshed(),
              );
            });
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<LocalTransactionsTransferBloc>();
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text(
                        'Current Balance: ',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      MoneyText(
                        cents: state.currentBalanceCents,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ValidatedTextField(
                    icon: Icons.person,
                    label: 'Beneficiary Name',
                    hint: "e.g. Jane O'Connor",
                    onChanged: (v) =>
                        bloc.add(LocalTransactionsBeneficiaryChanged(v)),
                    errorText: state.beneficiary.isEmpty || state.nameValid
                        ? null
                        : "2–50 letters, spaces, . ' - only",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 22),
                  ValidatedTextField(
                    icon: Icons.credit_card,
                    label: 'Account Number',
                    hint: '10–24 digits',
                    keyboardType: TextInputType.number,
                    onChanged: (v) =>
                        bloc.add(LocalTransactionsAccountChanged(v)),
                    errorText: state.accountNumber.isEmpty || state.accountValid
                        ? null
                        : 'Enter 10–24 digits only',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 22),
                  ValidatedTextField(
                    label: 'Amount',
                    hint: 'e.g. 25.00',
                    icon: Icons.attach_money,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) =>
                        bloc.add(LocalTransactionsAmountChanged(v)),
                    errorText: () {
                      if (state.amountText.isEmpty) return null;
                      if (!RegExp(r'^\d+(\.\d{1,2})?$')
                          .hasMatch(state.amountText)) {
                        return 'Positive number, max 2 decimals';
                      }
                      return state.amountValid
                          ? null
                          : 'Amount must be ≤ current balance';
                    }(),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  CustomLoadingButton(
                    controller: _loadingController,
                    title: "Send",
                    indicatorColor: AppColors.titleButtonColor(context),
                    titleColor: AppColors.titleButtonColor(context),
                    fillColor: state.isFormValid
                        ? AppColors.buttonColor(context)
                        : AppColors.buttonColor(context).withOpacity(0.5),
                    onTap: state.isFormValid && !state.submitting
                        ? () {
                      _loadingController.start();
                      Future.delayed(const Duration(seconds: 2), () {
                        _loadingController.success();
                        bloc.add(LocalTransactionsSubmitPressed());
                      });
                    }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
