import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AccountFilterShimmer extends StatelessWidget {
  const AccountFilterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, // Approximate width of a filter item
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}