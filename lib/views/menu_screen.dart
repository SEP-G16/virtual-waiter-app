import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            'Menu',
            style: TextConstants.mainTextStyle(),
          ),
        ),
      ),
    );
  }
}
