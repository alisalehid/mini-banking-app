import 'package:flutter/material.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class TransactionPlaceholder extends StatelessWidget {
  const TransactionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardBackground(context),
      highlightColor: Colors.grey.shade100,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circle placeholder on the left
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              // Transaction details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction type + amount row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 16, width: 150, color: Colors.white), // e.g., "Your withdrawal of MMK 334.04"
                        Container(height: 16, width: 80, color: Colors.white),  // e.g., "-$780.26"
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Date placeholder
                    Container(height: 14, width: 120, color: Colors.white), // e.g., "Oct 14, 2024"
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}