import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveInput extends StatelessWidget {
  final String formControlName;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Map<String, String Function(Object)>? validationMessages;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const CustomReactiveInput({
    super.key,
    required this.formControlName,
    required this.label,
    this.keyboardType,
    this.obscureText = false,
    this.validationMessages,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: formControlName,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validationMessages: validationMessages,
      inputFormatters: inputFormatters,
    );
  }
}
