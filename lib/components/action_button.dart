import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
    this.fillColour,
    this.borderColour,
    this.textColour,
    this.enableDefaultGradient = false,
    this.borderWidth,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.gradient,
    this.borderRadius,
    this.btnTextStyle
  });

  final void Function() onPressed;
  final String title;
  double? width;
  double? height;
  Color? fillColour;
  Color? borderColour;
  Color? textColour;
  bool enableDefaultGradient;
  double? borderWidth;
  String? fontFamily;
  double? fontSize;
  FontWeight? fontWeight;
  Gradient? gradient;
  double? borderRadius;
  TextStyle? btnTextStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        child: Container(
          width: width ?? 100,
          height: height ?? 50,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: fillColour ?? Colors.amber,
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            border: Border.all(color: borderColour ?? Colors.transparent, width: borderWidth ?? 1.0),
            gradient: gradient ?? (enableDefaultGradient ?  LinearGradient(
              colors: [
                Color(0xFF2A8A37),
                // Color(0x7E048316),
                Color(0x3F048316),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                0.4,
                1,
              ],
            ) : null),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: btnTextStyle ?? TextConstants.mainTextStyle(fontSize: fontSize ?? 18, fontWeight: fontWeight, textColor: textColour),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
