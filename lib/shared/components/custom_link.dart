import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomLink extends StatelessWidget {
  final String text;
  final Function() onTap;
  const CustomLink({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Text(
            text,
            style: TypographyStyles.label3().copyWith(color: ThemeColors.primary3)
          ),
        ),
      ),
    );
  }
}
