import 'package:flutter/material.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';

class CategoryTag extends StatelessWidget {
  const CategoryTag({
    super.key,
    required this.tagName,
    required this.color,
  });

  final String tagName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tagName,
        style: AppTextStyle.labelSmall.copyWith(color: Palette.white),
      ),
    );
  }
}
