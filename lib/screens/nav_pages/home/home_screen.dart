import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ThemeColors.primary3,
        child: const Center(
          child: Icon(
            Icons.qr_code_scanner_rounded,
            color: ThemeColors.white,
          ),
        ),
        shape: CircleBorder(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build,
              size: 45,
            ),
            Text(
              "Em construção",
              style: TypographyStyles.label2(),
            )
          ],
        ),
      ),
    );
  }
}
