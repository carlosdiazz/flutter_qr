import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final int maxLines;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.initialValue = '',
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: BorderSide(color: colors.primary.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(15),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(fontSize: 16, color: colors.onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorMessage,
        labelStyle: TextStyle(color: colors.primary),
        hintStyle: TextStyle(color: colors.onSurface.withOpacity(0.6)),
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
