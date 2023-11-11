import 'package:cap_navigation_bar/views/favorites_and_purchases_view.dart';
import 'package:cap_navigation_bar/views/home_view.dart';
import 'package:cap_navigation_bar/views/navigation_bar_view.dart';
import 'package:cap_navigation_bar/views/settings_view.dart';
import 'package:cap_navigation_bar/views/user_view.dart';
import 'package:flutter/material.dart';

Color? itemColor(
  Color focusedIconColor,
  int index,
  int currentIndex,
) =>
    index == currentIndex ? focusedIconColor : null;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final icons = <IconData>[
      Icons.person,
      Icons.home,
      Icons.shopping_cart,
      Icons.settings,
    ];
    final items = List.generate(
      icons.length,
      (index) => Icon(
        icons[index],
        color: itemColor(scaffoldColor, index, selectedIndex),
      ),
    );

    final screens = <Widget>[
      const UserView(),
      const HomeView(),
      const FavoritesAndPurchasesView(),
      const SettingsView(),
    ];

    return SafeArea(
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: CapNavigationBar(
          items: items,
          index: selectedIndex,
          onTap: (index) => setState(
            () => selectedIndex = index,
          ),
        ),
      ),
    );
  }
}
