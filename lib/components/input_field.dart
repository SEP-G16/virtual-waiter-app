import 'package:flutter/material.dart';

import '../constants/text_constants.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.labelText,
    required this.onChanged,
    this.height,
    this.width,
    this.initialValue,
    this.readOnly = false,
  });

  double? width;
  double? height;
  final String labelText;
  final Function(String? value) onChanged;
  bool readOnly;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: width ?? 300,
      height: height ?? 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly,
        initialValue: initialValue,
        onChanged: onChanged,
        style: TextConstants.subTextStyle(fontSize: 22),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextConstants.subTextStyle(fontSize: 22,
            textColor: Colors.black.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.all(20.0),
          isCollapsed: true,
          isDense: true,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          floatingLabelStyle: TextStyle(color: Colors.transparent),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
