import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';
import '../widgets/transaction_card.dart';
import '../widgets/transaction_placeholder.dart';


class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(LoadTransactions(page: 1, limit: 10));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<TransactionBloc>().add(LoadMoreTransactions());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return ListView.builder(
                itemCount: 5, // show 5 skeletons
                itemBuilder: (_, __) => const TransactionPlaceholder(),
              );
            } else if (state is TransactionLoaded) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.transactions.length
                    : state.transactions.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.transactions.length) {
                    return const TransactionPlaceholder();
                  }
                  final tx = state.transactions[index];
                  return TransactionCard(transaction: tx);              },
              );
            } else if (state is TransactionError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
