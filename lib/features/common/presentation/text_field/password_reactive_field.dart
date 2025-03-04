import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordReactiveField extends StatefulWidget {
  final String formControlName;
  final String label;
  final Map<String, String Function(Object)>? validationMessages;

  const PasswordReactiveField({
    super.key,
    required this.formControlName,
    required this.label,
    this.validationMessages,
  });

  @override
  State<PasswordReactiveField> createState() => _PasswordReactiveFieldState();
}

class _PasswordReactiveFieldState extends State<PasswordReactiveField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: widget.formControlName,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleVisibility,
        ),
      ),
      validationMessages: widget.validationMessages,
    );
  }
}
