import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/message_dialog_box.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/views/welcome_screen_controller.dart';
import 'package:virtual_waiter/views/menu_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: TextButton(
        onPressed: () async {
          try {
            await WelcomeScreenController.instance.onTapForRequestHelpBtn();
          } catch (e) {
            MessageDialogBox(
              message: 'An unexpected error occurred!',
              borderColor: Colors.redAccent,
            );
          }
        },
        child: Text(
          'Request\nHelp',
          style: TextConstants.subTextStyle(
            fontSize: 20,
            textColor: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hi! I\'m your Virtual Waiter!',
                  style: TextConstants.mainTextStyle(),
                ),
                GestureDetector(
                  onTap: (){
                    //Moving to menu section
                    Get.to(() => MenuScreen());
                  },
                  child: Container(
                    width: 250.0,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed to Menu',
                          style: TextConstants.subTextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
