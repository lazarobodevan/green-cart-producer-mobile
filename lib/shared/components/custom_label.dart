import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomLabel extends StatelessWidget {
  final String text;

  const CustomLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TypographyStyles.label2(),
    );
  }
}
