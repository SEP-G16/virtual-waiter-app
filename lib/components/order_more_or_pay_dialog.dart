import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';

import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';
import '../views/menu_screen.dart';
import '../views/payment_screen.dart';
import 'action_button.dart';

class OrderMoreOrPayDialog {
  OrderMoreOrPayDialog() {
    _showDialog();
  }

  void _showDialog() {
    Get.dialog(
        Dialog(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hope you’ve enjoyed your meals!\nWould you like to order anything else,\nor are you ready to settle the bill?",
                  style: TextConstants.mainTextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => Get.offAll(() => MenuScreen()),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.add_circle_outline_rounded),
                            SvgPicture.string(
                              SvgConstants.waiterWritingSvg,
                              height: 60,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Order More',
                              style: TextConstants.subTextStyle(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        WebSocketController.instance.sendReadyToPayMessage();
                        Get.offAll(() => PaymentScreen());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.add_circle_outline_rounded),
                            SvgPicture.string(
                              SvgConstants.customerSvg,
                              height: 60,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Settle Bill',
                              style: TextConstants.subTextStyle(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
