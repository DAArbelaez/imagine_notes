import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_notes/core/constants/palette.dart';

class AppTextStyle {
  static TextStyle headlineSmall = GoogleFonts.krub(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Palette.textColor,
  );

  static TextStyle titleMedium = GoogleFonts.krub(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Palette.textColor,
  );

  static TextStyle bodyMedium = GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Palette.textColor,
  );

  static TextStyle bodySmall = GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Palette.textColor,
  );

  static TextStyle labelSmall = GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Palette.textColor,
  );

  static TextStyle buttonMedium = GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Palette.textColor,
  );

  static TextStyle buttonSmall = GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Palette.textColor,
  );
}
