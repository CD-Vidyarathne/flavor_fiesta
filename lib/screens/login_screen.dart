import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? appFlavor = const String.fromEnvironment('FLUTTER_APP_FLAVOR') != ''
      ? const String.fromEnvironment('FLUTTER_APP_FLAVOR')
      : null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      UserCredential? userCredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);

      if (appFlavor == "admin") {
        if (userCredentials.user != null) {
          String loggedEmail = userCredentials.user!.email!;
          bool isAdmin = await checkUserIsAdmin(loggedEmail);

          if (isAdmin) {
            Navigator.pushNamed(context,
                AppRoutes.authenticated); // Navigate to an admin-specific route
          } else {
            displayMessageToUser("User is not an admin", context);
          }
        }
      } else if (appFlavor == "user") {
        displayMessageToUser("Login Success", context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  Future<bool> checkUserIsAdmin(String email) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(email).get();

    if (userDoc.exists) {
      return userDoc.data()?['isAdmin'] ?? false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(AppMedia.logo),
                  ),
                ),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: loginUser,
              style: AppStyles.darkButton,
              child: const Text('Log In'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
              child: Text(
                "Don't have an account? Sign up",
                style: AppStyles.textStyle,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
