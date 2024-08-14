import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fiesta/core/entities/e_user.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? appFlavor = const String.fromEnvironment('FLUTTER_APP_FLAVOR') != ''
      ? const String.fromEnvironment('FLUTTER_APP_FLAVOR')
      : null;
  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    if (password != confirmPassword) {
      Navigator.pop(context);
      displayMessageToUser("Passwords does not match.", context);
    } else {
      try {
        UserCredential? userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        createUser(userCredentials);

        if (context.mounted) Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.login);
        displayMessageToUser("Registration Success", context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUser(UserCredential? userCredential) async {
    final userName = userNameController.text;
    if (userCredential != null && userCredential.user != null) {
      AppUser userData = AppUser(
          userId: userCredential.user!.uid,
          userName: userName,
          isAdmin: appFlavor == "admin" ? true : false,
          email: userCredential.user!.email!,
          previousOrders: []);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set(userData.toMap());
    }
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
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
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
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: registerUser,
              style: AppStyles.darkButton,
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              child: Text(
                "Already have an account? Log In",
                style: AppStyles.textStyle,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
