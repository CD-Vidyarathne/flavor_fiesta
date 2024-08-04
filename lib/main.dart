import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/widgets/navigator_bar.dart';
import 'package:flavor_fiesta/screens/google_map_screen.dart';
import 'package:flavor_fiesta/screens/landing_screen.dart';
import 'package:flavor_fiesta/screens/login_screen.dart';
import 'package:flavor_fiesta/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //--Authentication disabled due to development--
        // "/": (context) => const LandingScreen(),
        "/": (context) => const NavigatorBar(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.map: (context) => const GoogleMapScreen()
        // AppRoutes.authenticated: (context) => const NavigatorBar()
      },
    );
  }
}
