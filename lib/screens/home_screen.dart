import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    Text(
                      "<UserName>",
                      style: AppStyles.headLineStyle1.copyWith(
                          color: AppStyles.paletteMedium, fontSize: 45),
                    ),
                  ],
                ))));
  }
}
