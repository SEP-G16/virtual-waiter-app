import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../constants/text_constants.dart';
import '../views/loading_screen.dart';
import '../views/menu_screen.dart';
import 'action_button.dart';

class OrderMoreOrLeaveDialog{
  OrderMoreOrLeaveDialog() {
    _showDialog();
  }

  void _showDialog()
  {
    Get.dialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.all(
            10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Looks like all your orders have been rejected.\nWe\'re sorry for the inconvenience.\nWould you like to order something else or leave?',
                style: TextConstants.mainTextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionButton(
                      width: 150,
                      title: 'Leave',
                      onPressed: () {
                        Get.offAll(() => LoadingScreen());
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  ActionButton(
                      width: 150,
                      title: 'Order More',
                      onPressed: () {
                        Get.to(() => MenuScreen());
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}