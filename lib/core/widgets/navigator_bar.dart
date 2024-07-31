import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/screens/home_screen.dart';
import 'package:flavor_fiesta/screens/order_history_screen.dart';
import 'package:flavor_fiesta/screens/order_now_screen.dart';
import 'package:flavor_fiesta/screens/profile_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;

  final appScreens = [
    const HomeScreen(),
    const OrderNowScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: appScreens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppStyles.paletteBlack,
        unselectedItemColor: AppStyles.paletteLight,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
              backgroundColor: AppStyles.paletteDark,
              icon: const Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: const Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home"),
          BottomNavigationBarItem(
              backgroundColor: AppStyles.paletteDark,
              icon: const Icon(FluentSystemIcons.ic_fluent_food_regular),
              activeIcon: const Icon(FluentSystemIcons.ic_fluent_food_filled),
              label: "Order Now"),
          BottomNavigationBarItem(
              backgroundColor: AppStyles.paletteDark,
              icon: const Icon(FluentSystemIcons.ic_fluent_history_regular),
              activeIcon:
                  const Icon(FluentSystemIcons.ic_fluent_history_filled),
              label: "History"),
          BottomNavigationBarItem(
              backgroundColor: AppStyles.paletteDark,
              icon: const Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: const Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "Profile")
        ],
      ),
    );
  }
}
