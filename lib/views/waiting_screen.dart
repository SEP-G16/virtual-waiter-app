import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The Waiter will notify the kitchen about your order!', style: TextConstants.mainTextStyle(), textAlign: TextAlign.center,),
          ],
        ),
      ),
    ),);
  }
}
