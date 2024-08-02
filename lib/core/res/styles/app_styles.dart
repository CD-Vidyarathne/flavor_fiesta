import 'package:flutter/material.dart';

class AppStyles {
  static Color paletteBlack = const Color(0xFF56765C);
  static Color paletteGrey = const Color(0xFF88AB8E);
  static Color paletteDark = const Color(0xFFAFC8AD);
  static Color paletteMedium = const Color(0xFFEEE7DA);
  static Color paletteLight = const Color(0xFFF2F1EB);
  static Color greyBgColor = const Color(0xFFEEEEEE);
  static Color redColor = const Color(0xFFE64A19);
  static Color blackColor = const Color(0xFF424242);

  static TextStyle textStyle =
      TextStyle(fontSize: 16, color: paletteGrey, fontWeight: FontWeight.w500);

  static TextStyle textBlackStyle1 =
      TextStyle(fontSize: 18, color: blackColor, fontWeight: FontWeight.bold);

  static TextStyle textBlackStyle2 =
      TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.w400);

  static TextStyle headLineStyle1 =
      TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: paletteBlack);

  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: paletteBlack);

  static TextStyle headLineStyle3 =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: paletteGrey);

  static TextStyle headLineStyle4 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: paletteGrey);

  static ButtonStyle darkButton = ElevatedButton.styleFrom(
    backgroundColor: paletteBlack,
    foregroundColor: paletteMedium,
    textStyle: textStyle,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static ButtonStyle lightButton = ElevatedButton.styleFrom(
    backgroundColor: paletteMedium,
    foregroundColor: paletteBlack,
    textStyle: textStyle,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: paletteBlack, // Border color
        width: 2.0, // Border width
      ),
    ),
  );
  static ButtonStyle darkButtonSquare = ElevatedButton.styleFrom(
    backgroundColor: paletteBlack,
    foregroundColor: paletteMedium,
    textStyle: textStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static ButtonStyle lightButtonSquare = ElevatedButton.styleFrom(
    backgroundColor: paletteMedium,
    foregroundColor: paletteBlack,
    textStyle: textStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: paletteBlack, // Border color
        width: 2.0, // Border width
      ),
    ),
  );
  static ButtonStyle redButton = ElevatedButton.styleFrom(
    backgroundColor: redColor,
    foregroundColor: paletteMedium,
    textStyle: textStyle,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
