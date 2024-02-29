import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title != null? title! : "",
        style: TypographyStyles.label1(),
      ),
      centerTitle: true,
      toolbarHeight: 70,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 15),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(40),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ThemeColors.gray6),
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
