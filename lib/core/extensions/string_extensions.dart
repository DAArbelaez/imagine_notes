import 'package:flutter/material.dart';

extension HexColorExtension on String {
  /// Converts a hex color string (e.g., "#RRGGBB" or "#AARRGGBB") to a [Color] object.
  ///
  /// - Supports both 6-character and 8-character hex values.
  /// - Automatically adds '0xFF' for opaque colors if alpha is not provided.
  /// - Returns [Colors.transparent] if the string is invalid.
  Color toColor() {
    final hex = replaceFirst('#', '');
    if (hex.length == 6) {
      return Color(int.parse('0xFF$hex'));
    } else if (hex.length == 8) {
      return Color(int.parse('0x$hex'));
    }
    return Colors.transparent;
  }
}
