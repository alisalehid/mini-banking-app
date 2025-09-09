import 'package:flutter/material.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../domain/entities/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWithdrawal = transaction.status == "withdrawal";

    final iconWidget = isWithdrawal
        ? Image.asset(
      'assets/images/withdrawal.png',
      width: 12, // Slightly increased icon size
      height: 12,
      color: Colors.red[400],
    )
        : Image.asset(
      'assets/images/income.png',
      width: 12,
      height: 12,
      color: Colors.green[400],
    );

    final backgroundColor = isWithdrawal ? Colors.red[50] : Colors.green[50];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // Increased margin
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10), // Increased padding
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: iconWidget,
          ),
          const SizedBox(width: 16), // Increased spacing between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description.split(' at ')[0], // Name only
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4), // Added spacing between text lines
                Text(
                  _formatDate(transaction.date),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${isWithdrawal ? '-' : '+'}\$${transaction.amount}",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isWithdrawal ? Colors.red[700] : Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "Oct ${date.day}, ${date.year}";
  }
}