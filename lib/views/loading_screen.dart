import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller_initializer.dart';
import 'package:virtual_waiter/views/waiting_screen.dart';
import 'package:virtual_waiter/views/welcome_screen.dart';

import '../constants/text_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<String> initControllers() async {
    try {
      if (!ControllerInitializer.initialized) {
        await ControllerInitializer.initAllControllers();
      }
      return 'Done';
    } catch (e) {
      print('Error loading controllers');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initControllers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(OrderDataController.previousSession)
              {
                return WaitingScreen(previousSession: true,);
              }
            return WelcomeScreen();
          } else if (snapshot.hasError) {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'An unexpected error occurred!',
                    style: TextConstants.mainTextStyle(textColor: Colors.red),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: Center(child: CircularProgressIndicator(color: Colors.amber,),)
                ),
              ),
            );
          }
        });
  }
}
