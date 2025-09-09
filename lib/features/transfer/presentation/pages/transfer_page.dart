import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/money_transfer_bloc.dart';

class MoneyTransferPage extends StatefulWidget {
  const MoneyTransferPage({super.key});

  @override
  State<MoneyTransferPage> createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  final _formKey = GlobalKey<FormState>();
  final beneficiaryController = TextEditingController();
  final accountController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoneyTransferBloc, MoneyTransferState>(
      listener: (context, state) {
        if (state is MoneyTransferSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Money sent successfully!')),
          );
          Navigator.pop(context);
        }
        if (state is MoneyTransferFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Send Money')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: beneficiaryController,
                  decoration: const InputDecoration(labelText: 'Beneficiary Name'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: accountController,
                  decoration: const InputDecoration(labelText: 'Account Number'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final amount = double.tryParse(amountController.text) ?? 0;
                      context.read<MoneyTransferBloc>().add(
                        SendMoney(
                          beneficiary: beneficiaryController.text,
                          accountNumber: accountController.text,
                          amount: amount,
                        ),
                      );
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
