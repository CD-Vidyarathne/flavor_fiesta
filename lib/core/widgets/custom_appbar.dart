import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  const CustomAppbar(
      {super.key, required this.title, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppStyles.headLineStyle2.copyWith(color: AppStyles.paletteBlack),
      ),
      backgroundColor: AppStyles.paletteDark,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppStyles.paletteBlack),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      actions: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(image: AssetImage(AppMedia.logo))),
        )
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
