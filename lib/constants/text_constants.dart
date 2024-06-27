import 'package:flutter/material.dart';

class TextConstants {
  static TextStyle mainTextStyle(
      {double? fontSize, String? fontFamily, FontWeight? fontWeight, Color? textColor}) {
    return TextStyle(
      fontSize: fontSize ?? 40.0,
      fontFamily: fontFamily ?? 'Altone Trial',
      fontWeight: fontWeight ?? FontWeight.w700,
      color: textColor,
    );
  }

  static subTextStyle(
      {double? fontSize, String? fontFamily, FontWeight? fontWeight, Color? textColor}) {
    return TextStyle(
      fontSize: fontSize ?? 30.0,
      fontFamily: fontFamily ?? 'Altone Trial',
      fontWeight: fontWeight ?? FontWeight.w500,
      color: textColor,
    );
  }
}
