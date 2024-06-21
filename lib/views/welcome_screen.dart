import 'package:flutter/material.dart';
import 'package:virtual_waiter/components/message_dialog_box.dart';
import 'package:virtual_waiter/controller/views/welcome_screen_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hi! I\'m your Virtual Waiter!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await WelcomeScreenController.instance
                          .onTapForRequestHelpBtn();
                    } catch (e) {
                      MessageDialogBox(
                        message: 'An unexpected error occurred!',
                        borderColor: Colors.redAccent,
                      );
                    }
                  },
                  child: Text('Request Help'),
                ),
              ],
            )),
      ),
    );
  }
}
