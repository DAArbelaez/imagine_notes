import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveTextField extends StatelessWidget {
  final String formControlName;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Map<String, String Function(Object)>? validationMessages;

  const CustomReactiveTextField({
    super.key,
    required this.formControlName,
    required this.label,
    this.keyboardType,
    this.obscureText = false,
    this.validationMessages,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: formControlName,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validationMessages: validationMessages,
    );
  }
}
