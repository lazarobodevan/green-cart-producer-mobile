import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';

import 'custom_bottom_navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List barItems;
  final List pages;
  int currentIndex;
  final Function(int) onIndexChanged;
  CustomBottomNavigationBar({super.key, required this.barItems, required this.pages, required this.currentIndex, required this.onIndexChanged});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ThemeColors.black.withOpacity(.25),
                    offset: Offset(0, -2),
                    spreadRadius: 0,
                    blurRadius: 4)
              ],
              color: ThemeColors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: widget.barItems.asMap().entries.map<Widget>((entry) {
              if (entry.key == widget.currentIndex) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          widget.currentIndex = entry.key;
                          widget.onIndexChanged(entry.key);
                        });
                      },
                      child: CustomBottomNavigationBarItem(
                        text: entry.value['text'],
                        icon: entry.value['icon'],
                        isActive: true,
                      ),
                    ));
              }
              return InkWell(
                onTap: (){
                  setState(() {
                    widget.currentIndex = entry.key;
                    widget.onIndexChanged(entry.key);
                  });
                },
                child: CustomBottomNavigationBarItem(
                  text: entry.value['text'],
                  icon: entry.value['icon'],
                  isActive: false,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
