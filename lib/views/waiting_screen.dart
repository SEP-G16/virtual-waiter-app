import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_waiter/constants/svg_constants.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/constants/web_socket_constants.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/stream_socket_controller.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: OrientationBuilder(builder: (context, orientation) {
            return Column(
              children: [
                StreamBuilder(
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
                      switch (snapshot.data) {
                        case WebSocketConstants.showOrderAccepted:
                          child = Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.string(
                              //   SvgConstants.chefSvg,
                              //   height: orientation == Orientation.portrait
                              //       ? deviceHeight * 0.3
                              //       : null,
                              //   width: orientation == Orientation.landscape
                              //       ? deviceWidth * 0.3
                              //       : null,
                              // ),
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Text(
                                'Our chefs have accepted your order!',
                                style:
                                    TextConstants.mainTextStyle(fontSize: 32),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                          break;

                        case WebSocketConstants.showOrderPrepared:
                          child = Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.string(
                              //   SvgConstants.waiterDeliveringSvg,
                              //   height: orientation == Orientation.portrait
                              //       ? deviceHeight * 0.3
                              //       : null,
                              //   width: orientation == Orientation.landscape
                              //       ? deviceWidth * 0.3
                              //       : null,
                              // ),
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Text(
                                'You\'re meals has been prepared\nA waiter will deliver them to you shortly!',
                                style:
                                    TextConstants.mainTextStyle(fontSize: 32),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                          break;

                        default:
                          child = Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.string(
                              //   SvgConstants.waiterSvg,
                              //   height: orientation == Orientation.portrait
                              //       ? deviceHeight * 0.3
                              //       : null,
                              //   width: orientation == Orientation.landscape
                              //       ? deviceWidth * 0.3
                              //       : null,
                              // ),
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Text(
                                'The Waiter will notify the kitchen\nabout your order!',
                                style:
                                    TextConstants.mainTextStyle(fontSize: 32),
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
                          // SvgPicture.string(
                          //   SvgConstants.waiterSvg,
                          //   height: orientation == Orientation.portrait
                          //       ? deviceHeight * 0.3
                          //       : null,
                          //   width: orientation == Orientation.landscape
                          //       ? deviceWidth * 0.3
                          //       : null,
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          Text(
                            'The Waiter will notify the kitchen\nabout your order!',
                            style: TextConstants.mainTextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                  },
                ),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Colors.black.withOpacity(0.7),
                  thickness: 1,
                ),
                Text(
                  'Your Orders',
                  style: TextConstants.subTextStyle(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  //Image
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 80.0,
                                      height: 80.0,
                                      imageUrl:
                                          'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${'Spring Rolls'}',
                                      style: TextConstants.mainTextStyle(
                                          fontSize: 25),
                                    ),
                                    Text(
                                      'Quantity - ${2}x',
                                      style: TextConstants.subTextStyle(
                                          fontSize: 24),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  '\$${5.99}',
                                  style:
                                      TextConstants.mainTextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black.withOpacity(0.7),
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextConstants.mainTextStyle(fontSize: 36),
                            ),
                            Text(
                              '\$${5.99}',
                              style: TextConstants.mainTextStyle(fontSize: 36),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black.withOpacity(0.7),
                        thickness: 1,
                        height: 5,
                      ),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black.withOpacity(0.7),
                        thickness: 1,
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
