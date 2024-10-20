import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/text_constants.dart';
import 'action_button.dart';

class MessageDialogBox {
  final String message;
  String? btnText;
  void Function()? onTap;

  MessageDialogBox({required this.message, this.onTap, this.btnText}) {
    _showDialog();
  }

  void _showDialog() {
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextConstants.subTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                title: btnText ?? 'OK',
                onPressed: onTap ?? () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
