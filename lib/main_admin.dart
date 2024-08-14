import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/widgets/navigator_bar.dart';
import 'package:flavor_fiesta/firebase_options.dart';
import 'package:flavor_fiesta/screens/add_new_food_screen.dart';
import 'package:flavor_fiesta/screens/add_new_shop_screen.dart';
import 'package:flavor_fiesta/screens/landing_screen.dart';
import 'package:flavor_fiesta/screens/login_screen.dart';
import 'package:flavor_fiesta/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String? appFlavor =
      const String.fromEnvironment('FLUTTER_APP_FLAVOR') != ''
          ? const String.fromEnvironment('FLUTTER_APP_FLAVOR')
          : null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const LandingScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.authenticated: (context) => const NavigatorBar(),
        AppRoutes.addNewShop: (context) => const AddNewShopScreen(),
        AppRoutes.addNewFood: (context) => const AddNewFoodScreen()
      },
    );
  }
}
