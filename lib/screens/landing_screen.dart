import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppMedia.landingBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "WELCOME TO,",
                  style: AppStyles.headLineStyle1
                      .copyWith(color: AppStyles.paletteLight),
                ),
                const SizedBox(height: 40),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppStyles.paletteBlack,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Text(
                    "Flavor Fiesta",
                    style: AppStyles.headLineStyle1
                        .copyWith(color: AppStyles.paletteMedium, fontSize: 35),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Please Log in or sign up to continue.",
                  style: AppStyles.headLineStyle1
                      .copyWith(color: AppStyles.paletteMedium),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //---Login button----
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.login),
            child: Container(
                height: 100,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: AppStyles.paletteDark,
                  border: Border(
                    top: BorderSide(width: 3.0, color: AppStyles.paletteMedium),
                    right:
                        BorderSide(width: 1.5, color: AppStyles.paletteMedium),
                  ),
                ),
                child: Center(
                  child: Text(
                    "LOG IN",
                    textAlign: TextAlign.center,
                    style: AppStyles.headLineStyle2.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppStyles.paletteBlack),
                  ),
                )),
          ),
          //---Signup button----
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
            child: Container(
                height: 100,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: AppStyles.paletteDark,
                  border: Border(
                    top: BorderSide(width: 3.0, color: AppStyles.paletteMedium),
                    left:
                        BorderSide(width: 1.5, color: AppStyles.paletteMedium),
                  ),
                ),
                child: Center(
                  child: Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: AppStyles.headLineStyle2.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppStyles.paletteBlack),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
