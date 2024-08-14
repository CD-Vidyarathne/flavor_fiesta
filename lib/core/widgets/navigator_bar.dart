import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fiesta/core/helpers/app_data.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/screens/food_management_screen.dart';
import 'package:flavor_fiesta/screens/home_screen.dart';
import 'package:flavor_fiesta/screens/order_history_screen.dart';
import 'package:flavor_fiesta/screens/order_management_screen.dart';
import 'package:flavor_fiesta/screens/order_now_screen.dart';
import 'package:flavor_fiesta/screens/profile_screen.dart';
import 'package:flavor_fiesta/screens/shop_management_screen.dart';
import 'package:flavor_fiesta/screens/user_management_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;
  late List<Widget> appScreens;
  late List<BottomNavigationBarItem> navBarItems;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushNamed(context, AppRoutes.login);
      }
    });

    AppData().initialize(
      flavor: const String.fromEnvironment('FLUTTER_APP_FLAVOR'),
      user: FirebaseAuth.instance.currentUser,
    );

    if (AppData().appFlavor == "admin") {
      appScreens = [
        const UserManagementScreen(),
        const ShopManagementScreen(),
        const FoodManagementScreen(),
        const OrderManagementScreen(),
        const ProfileScreen(),
      ];

      navBarItems = [
        BottomNavigationBarItem(
            backgroundColor: AppStyles.paletteDark,
            icon: const Icon(FluentSystemIcons.ic_fluent_people_regular),
            activeIcon: const Icon(FluentSystemIcons.ic_fluent_people_filled),
            label: "Users"),
        BottomNavigationBarItem(
            backgroundColor: AppStyles.paletteDark,
            icon: const Icon(FluentSystemIcons.ic_fluent_store_regular),
            activeIcon: const Icon(FluentSystemIcons.ic_fluent_store_filled),
            label: "Shops"),
        BottomNavigationBarItem(
            backgroundColor: AppStyles.paletteDark,
            icon: const Icon(FluentSystemIcons.ic_fluent_food_regular),
            activeIcon: const Icon(FluentSystemIcons.ic_fluent_food_filled),
            label: "Foods"),
        BottomNavigationBarItem(
            backgroundColor: AppStyles.paletteDark,
            icon:
                const Icon(FluentSystemIcons.ic_fluent_checkmark_lock_regular),
            activeIcon:
                const Icon(FluentSystemIcons.ic_fluent_checkmark_lock_filled),
            label: "Orders"),
        BottomNavigationBarItem(
            backgroundColor: AppStyles.paletteDark,
            icon: const Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: const Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: "Profile"),
      ];
    } else {
      appScreens = [
        HomeScreen(),
        const OrderNowScreen(),
        const OrderHistoryScreen(),
        const ProfileScreen(),
      ];

      navBarItems = [
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
            activeIcon: const Icon(FluentSystemIcons.ic_fluent_history_filled),
            label: "History"),
        BottomNavigationBarItem(
            backgroundColor: AppStyles.paletteDark,
            icon: const Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: const Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: "Profile"),
      ];
    }
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
        items: navBarItems,
      ),
    );
  }
}
