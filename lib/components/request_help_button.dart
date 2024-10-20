import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';
import '../controller/views/welcome_screen_controller.dart';
import 'message_dialog_box.dart';

class RequestHelpButton extends StatelessWidget {
  const RequestHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          await WelcomeScreenController.instance.onTapForRequestHelpBtn();
        } catch (e) {
          MessageDialogBox(
            message: 'An unexpected error occurred!',
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.string(SvgConstants.waiterSvg, height: 100,),
          Text(
            'Request\nHelp',
            style: TextConstants.subTextStyle(
              fontSize: 20,
              textColor: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
