import 'package:flutter/material.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool enabled;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color borderColor;
  final Color disabledBorderColor;
  final Color textColor;

  const CustomButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.enabled = true,
  })  : backgroundColor = Palette.primary,
        disabledBackgroundColor = Palette.grey,
        borderColor = Palette.primary,
        disabledBorderColor = Palette.grey,
        textColor = Palette.white;

  const CustomButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.enabled = true,
  })  : backgroundColor = Colors.white,
        disabledBackgroundColor = Colors.transparent,
        borderColor = Palette.primary,
        disabledBorderColor = Palette.greyLight,
        textColor = enabled ? Palette.primary : Palette.greyLight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        disabledBackgroundColor: disabledBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: enabled ? borderColor : disabledBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) ...[
              leftIcon!,
              const SizedBox(width: 8),
            ],
            Text(text, style: AppTextStyle.buttonSmall.copyWith(color: textColor, fontWeight: FontWeight.w600)),
            if (rightIcon != null) ...[
              const SizedBox(width: 8),
              rightIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
