import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/views/loading_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(VirtualWaiter());
}

class VirtualWaiter extends StatelessWidget {
  const VirtualWaiter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Waiter',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoadingScreen(),
    );
  }
}
