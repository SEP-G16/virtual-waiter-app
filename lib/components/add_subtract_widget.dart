import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class AddSubtractWidget extends StatelessWidget {
  AddSubtractWidget({
    this.borderWidth = 2,
    this.sideLength = 50,
    this.borderRadius = 10,
    this.borderColour = Colors.green,
    this.textStyle,
    required this.value,
    required this.onAddPressed,
    required this.onSubtractPress,
  });

  double borderWidth;
  Color borderColour;
  double borderRadius;
  double sideLength;
  TextStyle? textStyle;
  int value;
  Function() onAddPressed;
  Function() onSubtractPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onSubtractPress,
          child: Container(
            height: sideLength,
            width: sideLength,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                bottomLeft: Radius.circular(borderRadius),
              ),
              border: Border(
                top: BorderSide(
                  color: borderColour,
                  width: borderWidth,
                ),
                left: BorderSide(
                  color: borderColour,
                  width: borderWidth,
                ),
                bottom: BorderSide(
                  color: borderColour,
                  width: borderWidth,
                ),
              ),
            ),
            child: Icon(MdiIcons.minus),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: sideLength,
          width: sideLength,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColour,
              width: borderWidth,
            ),
          ),
          child: Text(
            value.toString(),
            style: textStyle ?? TextConstants.subTextStyle(fontSize: 25),
          ),
        ),
        GestureDetector(
          onTap: onAddPressed,
          child: Container(
            height: sideLength,
            width: sideLength,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
              border: Border(
                top: BorderSide(
                  color: borderColour,
                  width: borderWidth,
                ),
                right: BorderSide(
                  color: borderColour,
                  width: borderWidth,
                ),
                bottom: BorderSide(
                  color: borderColour,
                  width: borderWidth,
                ),
              ),
            ),
            child: Icon(MdiIcons.plus),
          ),
        ),
      ],
    );
    ;
  }
}
