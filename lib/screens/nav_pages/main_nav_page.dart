
import 'package:flutter/material.dart';
import 'package:mobile_producer/screens/nav_pages/my_store/my_store_screen.dart';
import 'package:mobile_producer/screens/nav_pages/home/home_screen.dart';
import 'package:mobile_producer/screens/nav_pages/more/more_screen.dart';
import 'package:mobile_producer/screens/nav_pages/orders/orders_screen.dart';
import 'package:mobile_producer/shared/components/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List pages = [HomeScreen(), OrdersScreen(), MyStoreScreen(), MoreScreen()];
  List barItems = [
    {"text": "Home", "icon": Icons.home_outlined},
    {"text": "Pedidos", "icon": Icons.handshake_outlined},
    {"text": "Loja", "icon": Icons.storefront},
    {"text": "Mais", "icon": Icons.more_vert}
  ];

  void _onIndexChanged(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
          barItems: barItems,
          currentIndex: currentIndex,
          pages: pages,
          onIndexChanged: _onIndexChanged
      ),
    );
  }
}
