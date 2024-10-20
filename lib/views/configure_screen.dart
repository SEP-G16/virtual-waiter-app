import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/components/loading_dialog.dart';
import 'package:virtual_waiter/components/message_dialog_box.dart';
import 'package:virtual_waiter/components/named_input_field.dart';
import 'package:virtual_waiter/constants/pinput_theme_constants.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';
import 'package:virtual_waiter/views/loading_screen.dart';
import 'package:virtual_waiter/views/qr_code_scanner.dart';

import '../constants/text_constants.dart';

class ConfigureScreen extends StatelessWidget {
  ConfigureScreen({this.withPin = true});

  bool withPin;

  @override
  Widget build(BuildContext context) {
    return !withPin ? _ConfigureScreen() : Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Enter Pin to Enter Config Mode',
                            style: TextConstants.mainTextStyle(fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinput(
                    defaultPinTheme: PinputThemeConstants.defaultPinTheme,
                    focusedPinTheme: PinputThemeConstants.focusedPinTheme,
                    submittedPinTheme: PinputThemeConstants.submittedPinTheme,
                    validator: (s) {
                      return s == '1610' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      if (pin == '1610') {
                        Get.to(() => _ConfigureScreen());
                      }
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfigureScreen extends StatelessWidget {
  const _ConfigureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Configure Virtual Waiter',
                style: TextConstants.mainTextStyle(fontSize: 32),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scan QR code from Restaurant Manager Application\nto configure this Virtual Waiter',
                      textAlign: TextAlign.center,
                      style: TextConstants.subTextStyle(),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Get.to(
                      () => QrCodeScanner(
                        setResult: (result) async {
                          bool isNumeric(String input) {
                            RegExp regex = RegExp(r'^\d+$');
                            return regex.hasMatch(input);
                          }

                          if (result == null) {
                            MessageDialogBox(message: 'QR code not scanned');
                            return;
                          }

                          if (!isNumeric(result)) {
                            MessageDialogBox(message: 'Invalid QR code');
                            return;
                          }

                          int scannedId = int.parse(result);

                          LoadingDialog(
                            callerFunction: () async {
                              await TableDataController.instance.configureTable(
                                scannedId,
                              );
                            },
                            onSuccessCallBack: () {
                              MessageDialogBox(
                                  message: 'Table configured successfully');
                            },
                            onErrorCallBack: (error) {
                              MessageDialogBox(message: error.toString());
                            },
                          );
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.qr_code_scanner_outlined),
                  iconSize: 100,
                  color: Colors.black,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: ActionButton(
                title: 'Done',
                onPressed: () {
                  Get.offAll(() => LoadingScreen());
                },
                fontSize: 35,
                width: 150,
                height: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
