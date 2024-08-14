import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const CustomAppbar(title: 'Home', showBackButton: false),
        body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppMedia.homeBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning!",
                      style: AppStyles.headLineStyle1.copyWith(
                          color: AppStyles.paletteLight, fontSize: 32),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getUserDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.hasData) {
                          Map<String, dynamic>? user = snapshot.data!.data();
                          return Text(
                            user!["userName"],
                            style: AppStyles.headLineStyle1.copyWith(
                                color: AppStyles.paletteMedium, fontSize: 45),
                          );
                        } else {
                          return const Text("No Data");
                        }
                      },
                    ),
                  ],
                ))));
  }
}
