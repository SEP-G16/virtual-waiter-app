import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/components/named_input_field.dart';
import 'package:virtual_waiter/constants/pinput_theme_constants.dart';
import 'package:virtual_waiter/views/loading_screen.dart';

import '../constants/text_constants.dart';

class ConfigureScreen extends StatelessWidget {
  ConfigureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              icon: Icon(Icons.arrow_back_ios_new_rounded),),
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
                      if(pin == '1610')
                        {
                          Get.to(() => _ConfigureScreen());
                        }
                    },
                  ),
                  SizedBox(height: 100,),
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
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.offAll(LoadingScreen());
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Configure Virtual Waiter',
                      style: TextConstants.mainTextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  NamedInputField(
                    titleText: 'Edit Table No.',
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: ActionButton(
                title: 'Save',
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
