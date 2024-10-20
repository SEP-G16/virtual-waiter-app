import 'package:flutter/material.dart';

class TextConstants {

  TextConstants._();

  static TextStyle mainTextStyle(
      {double? fontSize, String? fontFamily, FontWeight? fontWeight, Color? textColor}) {
    return TextStyle(
      fontSize: fontSize ?? 40.0,
      fontFamily: fontFamily ?? 'Roundelay',
      fontWeight: fontWeight ?? FontWeight.w600,
      color: textColor,
    );
  }

  static subTextStyle(
      {double? fontSize, String? fontFamily, FontWeight? fontWeight, Color? textColor}) {
    return TextStyle(
      fontSize: fontSize ?? 30.0,
      fontFamily: fontFamily ?? 'Roundelay',
      fontWeight: fontWeight ?? FontWeight.w500,
      color: textColor,
    );
  }
}
