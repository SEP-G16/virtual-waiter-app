import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';

class QrCodeScanner extends StatelessWidget {
  QrCodeScanner({
    required this.setResult,
    super.key,
  });

  final Function setResult;
  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) async {
        final List<Barcode> barcodes = capture.barcodes;
        final barcode = barcodes.first;

        if (barcode.rawValue != null) {
          await controller
              .stop()
              .then((value) => controller.dispose())
              .then((value) async {
            await Future.delayed(Duration(seconds: 1));
            Get.back();
          });
          setResult(barcode.rawValue);
        }
      },
    );
  }
}
