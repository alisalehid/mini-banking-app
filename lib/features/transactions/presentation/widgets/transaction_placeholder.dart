import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';

class TransactionPlaceholder extends StatelessWidget {
  const TransactionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Shimmer.fromColors(
          baseColor: AppColors.cardBackground(context),
          highlightColor: Colors.grey.shade100,
          child: Row(
            children: [
              // Circle placeholder for the icon
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Colors.grey, // Shimmer color
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              // Expanded column for text placeholders
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for the main title
                    Container(
                      height: 14,
                      width: 150,
                      color: Colors.grey, // Shimmer color
                    ),
                    const SizedBox(height: 8),
                    // Placeholder for the sub-title (via account)
                    Container(
                      height: 14,
                      width: 100,
                      color: Colors.grey, // Shimmer color
                    ),
                    const SizedBox(height: 4),
                    // Placeholder for the date
                    Container(
                      height: 14,
                      width: 80,
                      color: Colors.grey, // Shimmer color
                    ),
                  ],
                ),
              ),
              // Placeholder for the amount
              Container(
                height: 16,
                width: 70,
                color: Colors.grey, // Shimmer color
              ),
            ],
          ),
        ),
      ),
    );
  }
}