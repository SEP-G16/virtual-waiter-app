import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_waiter/constants/svg_constants.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/constants/web_socket_constants.dart';
import 'package:virtual_waiter/controller/data/stream_socket_controller.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: OrientationBuilder(builder: (context, orientation) {
            return StreamBuilder(
              stream: StreamSocket.instance.getResponse,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'An Unexpected Error Has Occurred',
                      style: TextConstants.mainTextStyle(
                        textColor: Colors.redAccent,
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (snapshot.hasData) {
                  late Widget child;
                  switch (snapshot.data)
                  {
                    case WebSocketConstants.showOrderAccepted:
                      child = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(
                            SvgConstants.chefSvg,
                            height: orientation == Orientation.portrait
                                ? deviceHeight * 0.3
                                : null,
                            width: orientation == Orientation.landscape
                                ? deviceWidth * 0.3
                                : null,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Our chefs have accepted your order!',
                            style: TextConstants.mainTextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                      break;

                    case WebSocketConstants.showOrderPrepared:
                      child = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(
                            SvgConstants.waiterDeliveringSvg,
                            height: orientation == Orientation.portrait
                                ? deviceHeight * 0.3
                                : null,
                            width: orientation == Orientation.landscape
                                ? deviceWidth * 0.3
                                : null,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'You\'re meals has been prepared\nA waiter will deliver them to you shortly!',
                            style: TextConstants.mainTextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                      break;

                    default:
                      child = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(
                            SvgConstants.waiterSvg,
                            height: orientation == Orientation.portrait
                                ? deviceHeight * 0.3
                                : null,
                            width: orientation == Orientation.landscape
                                ? deviceWidth * 0.3
                                : null,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'The Waiter will notify the kitchen\nabout your order!',
                            style: TextConstants.mainTextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                      break;
                  }
                  return child;
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.string(
                        SvgConstants.waiterSvg,
                        height: orientation == Orientation.portrait
                            ? deviceHeight * 0.3
                            : null,
                        width: orientation == Orientation.landscape
                            ? deviceWidth * 0.3
                            : null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'The Waiter will notify the kitchen\nabout your order!',
                        style: TextConstants.mainTextStyle(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
              },
            );
          }),
        ),
      ),
    );
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('The Waiter will notify the kitchen about your order!', style: TextConstants.mainTextStyle(), textAlign: TextAlign.center,),
// ],
// ),
