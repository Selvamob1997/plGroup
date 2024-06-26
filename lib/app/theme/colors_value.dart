// coverage:ignore-file

import 'package:flutter/material.dart';

/// A list of custom color used in the application.
///
/// Will be ignored for test since all are static values and would not change.
abstract class ColorsValue {
  // static const int primaryColorCode = 0xff3c89fc;
  // static const int primaryColorCode = 0xff0047AB;
  // static const int primaryColorCode = 0xCDC5154B;
  static const int primaryColorCode = 0xff008AB3;  //#008ab3
  static const Color primaryColor = Color(primaryColorCode);

  // static const int primaryColorCode_dark = 0xBA105BFF;   //Color(0xCDC5154B)BA105BFF
  static const int primaryColorCode_dark = 0xffba105b;   //Color(0xCDC5154B)BA105BFF
  static const Color primaryColor_dark = Color(primaryColorCode_dark);

  var col = Colors.pink;
  var whitecolor = Colors.white;

  static const int buttonColorCode = 0xfffb9a0a;
  static const Color buttonColor = Color(buttonColorCode);

  static const int buttonFadedColorCode = 0xffBEBCBB;
  static const Color buttonFadedColor = Color(buttonFadedColorCode);

  static const int textFieldErrorCode = 0xffe63f36;
  static const Color textFieldErrorColor = Color(textFieldErrorCode);

  static Color backgroundColor = Colors.white;

  static Color blackcolor = Colors.black;

  static Color dropdownbordercolor = Colors.black38;

  static Color backgroudwhitecolor = Colors.black38;

  static const int lightGreyColorHex = 0xffa7b3c4;
  static const Color lightGreyColor = Color(
    lightGreyColorHex,
  );

  static const int brilliantWhiteCode = 0xffedf1fe;
  static const Color brilliantWhiteColor = Color(
    brilliantWhiteCode,
  );
}
