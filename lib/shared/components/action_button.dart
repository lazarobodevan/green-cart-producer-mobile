import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class ActionButton extends StatelessWidget {
  final bool isFilled;
  final Function() onTap;
  final String text;

  const ActionButton(
      {super.key,
      required this.isFilled,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: 136,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isFilled ? ThemeColors.primary3 : Colors.transparent,
          border: Border.all(color: isFilled ? Colors.transparent : ThemeColors.primary3)
        ),
        child: Center(
          child: Text(
            text,
            style: TypographyStyles.label3().copyWith(
                color: isFilled ? ThemeColors.white : ThemeColors.primary3),
          ),
        ),
      ),
    );
  }
}
