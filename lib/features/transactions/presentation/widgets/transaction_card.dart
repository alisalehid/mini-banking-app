import 'package:flutter/material.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../../local_transactions/domain/entities/dashboard_transaction.dart';

class TransactionCard extends StatelessWidget {
  final DashboardTransaction transaction;

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

    final backgroundColor = isWithdrawal ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1);
    final cleanAccount = transaction.account.replaceAll(RegExp(r'[_-]'), ' ');

    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10),

        child: Container(
          margin: const EdgeInsets.symmetric( vertical: 10), // Increased margin
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
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
                        color: AppColors.textColor(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // adds "..." when too long
                    ),

                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                        children: [
                          const TextSpan(text: "via "),
                          TextSpan(
                            text: cleanAccount,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600, // bold
                              color: Colors.grey[800],     // darker
                            ),
                          ),
                        ],
                      ),
                    ),                    Text(
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
        ),
      );

  }

  String _formatDate(DateTime date) {
    return "Oct ${date.day}, ${date.year}";
  }
}