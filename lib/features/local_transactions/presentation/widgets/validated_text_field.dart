import 'package:flutter/material.dart';

/// Simple reusable text field with inline error text.
class ValidatedTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String) onChanged;

  const ValidatedTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
