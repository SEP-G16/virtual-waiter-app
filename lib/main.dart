import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/views/loading_screen.dart';

void main() {
  runApp(const VirtualWaiter());
}

class VirtualWaiter extends StatelessWidget {
  const VirtualWaiter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Virtual Waiter',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoadingScreen(),
    );
  }
}

