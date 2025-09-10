import 'package:flutter/material.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';

class ValidatedTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String) onChanged;
  final IconData? icon;

  const ValidatedTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveDecoration = InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.hintColor,
        fontSize: 13,
      ),
      errorText: errorText,
      filled: true,
      fillColor: AppColors.cardBackground(context),
      prefixIcon: icon != null
          ? Icon(
        icon,
        color: AppColors.textColor(context),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    );

    return TextField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: effectiveDecoration,
      onChanged: onChanged,
    );
  }
}
