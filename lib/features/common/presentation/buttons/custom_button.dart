import 'package:flutter/material.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';

enum ButtonVariant { primary, secondary }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final ButtonVariant variant;

  const CustomButton._({
    super.key,
    required this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    required this.variant,
  });

  factory CustomButton.primary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    Widget? leftIcon,
    Widget? rightIcon,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      variant: ButtonVariant.primary,
    );
  }

  factory CustomButton.secondary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    Widget? leftIcon,
    Widget? rightIcon,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      variant: ButtonVariant.secondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle.buttonSmall.copyWith(
      fontWeight: FontWeight.w600,
      color: variant == ButtonVariant.primary ? Palette.white : Palette.primary,
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leftIcon != null) ...[
          leftIcon!,
          const SizedBox(width: 8.0),
        ],
        Text(text, style: textStyle),
        if (rightIcon != null) ...[
          const SizedBox(width: 8.0),
          rightIcon!,
        ],
      ],
    );

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: content,
        );
      case ButtonVariant.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: Palette.primary,
            side: BorderSide(color: Palette.primary),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: content,
        );
    }
  }
}
