import 'package:flutter/material.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Palette.surface,
    textTheme: TextTheme(
      headlineSmall: AppTextStyle.headlineSmall,
      titleMedium: AppTextStyle.titleMedium,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
      labelSmall: AppTextStyle.labelSmall,
    ),
  );
}