import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  const CustomIconButton({super.key, required this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: ThemeColors.primary3,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: ThemeColors.white,
                ),
                const SizedBox(width: 5,),
                Flexible(
                  child: Text(
                    text,
                    style: TypographyStyles.paragraph3().copyWith(color: ThemeColors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
