import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool isActive;
  final bool isLoading;

  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.isActive = true,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isActive ? ThemeColors.primary3 : ThemeColors.gray4,
          ),
          child: Center(
            child: isLoading ? CircularProgressIndicator() : Text(
              text,
              style: TypographyStyles.label2().copyWith(
                  color: ThemeColors.white),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isActive ? onTap : null,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
