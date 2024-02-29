import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomBottomNavigationBarItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  const CustomBottomNavigationBarItem({super.key, required this.text, required this.icon, this.isActive = false});

  @override
  State<CustomBottomNavigationBarItem> createState() => _CustomBottomNavigationBarItemState();
}

class _CustomBottomNavigationBarItemState extends State<CustomBottomNavigationBarItem> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (widget.isActive) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return widget.isActive == true ? ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.bounceIn,
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(color: ThemeColors.white),
            boxShadow: [
              BoxShadow(
                  color: ThemeColors.black.withOpacity(.25),
                  offset: const Offset(0,4),
                  blurRadius: 4
              ),
            ],
            color: ThemeColors.primary4,
            borderRadius: BorderRadius.circular(55)
        ),
        child: Icon(widget.icon, color: ThemeColors.white, weight: .1,),
      ),
    ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: ThemeColors.gray6,),
            Text(widget.text, style: TypographyStyles.label4().copyWith(color: ThemeColors.gray4),)
          ],
        )
    ;
  }
}
