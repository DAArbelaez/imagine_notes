import 'package:flutter/material.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/core/constants/palette.dart';

class CustomSnackBar {
  static void show(BuildContext context, {required String message, Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyle.bodySmall.copyWith(color: Palette.white),
        ),
        duration: duration,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
