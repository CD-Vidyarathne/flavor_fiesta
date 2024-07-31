import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class OrderNowScreen extends StatelessWidget {
  const OrderNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Now',
          style:
              AppStyles.headLineStyle2.copyWith(color: AppStyles.paletteBlack),
        ),
        backgroundColor: AppStyles.paletteDark,
        actions: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(image: AssetImage(AppMedia.logo))),
          )
        ],
      ),
    );
  }
}
