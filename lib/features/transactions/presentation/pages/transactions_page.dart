import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';
import '../widgets/transaction_card.dart';
import '../widgets/transaction_placeholder.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/account_filter_shimmer.dart'; // Import the new shimmer widget

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String _searchQuery = "";
  String _selectedAccount = "All";

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(LoadTransactions(page: 1, limit: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                hintText: "Search transactions...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.cardBackground(context),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 25),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoaded) {
                  final accounts = state.transactions
                      .map((tx) => tx.account)
                      .toSet()
                      .toList();

                  final filterOptions = ["All", ...accounts];

                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filterOptions.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final account = filterOptions[index];
                        final isSelected = _selectedAccount == account;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAccount = account;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [
                                  Color(0xFF4A90E2),
                                  Color(0xFFFF5F6D),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : LinearGradient(
                                colors: [
                                  AppColors.cardBackground(context),
                                  AppColors.cardBackground(context),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                account.replaceAll(RegExp(r'[_-]'), ' '),
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textColor(context),
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is TransactionLoading) {
                  // Show the shimmer effect for the horizontal filters
                  return SizedBox(
                    height: 40,
                    child: Shimmer.fromColors(
                      baseColor: AppColors.cardBackground(context),
                      highlightColor: Colors.grey.shade100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10, // Show a fixed number of placeholder items
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return const AccountFilterShimmer();
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return ListView.builder(
                      itemCount: 20,
                      itemBuilder: (_, __) => const TransactionPlaceholder(),
                    );
                  } else if (state is TransactionLoaded) {
                    final filteredTransactions = state.transactions.where((tx) {
                      final matchesSearch = tx.description.toLowerCase().contains(_searchQuery);
                      final matchesAccount = _selectedAccount == "All" || tx.account == _selectedAccount;
                      return matchesSearch && matchesAccount;
                    }).toList();

                    if (filteredTransactions.isEmpty) {
                      return const Center(
                        child: Text("Nothing found"),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final tx = filteredTransactions[index];
                        return TransactionCard(transaction: tx);
                      },
                    );
                  } else if (state is TransactionError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}