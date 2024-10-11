import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/components/order_item_tile.dart';
import 'package:virtual_waiter/constants/svg_constants.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/constants/web_socket_constants.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/controller/data/stream_socket_controller.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controller/views/waiting_screen_state_controller.dart';
import 'package:virtual_waiter/enums/order_status.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/views/menu_screen.dart';
import 'package:virtual_waiter/views/view_menu_item_screen.dart';

import '../controller/views/view_menu_item_screen/vmis_state_controller.dart';
import '../model/order.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WaitingScreenStateController());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Get.offAll(() => MenuScreen()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon(Icons.add_circle_outline_rounded),
                  SvgPicture.string(
                    SvgConstants.waiterWritingSvg,
                    height: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Order More',
                    style: TextConstants.subTextStyle(),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: OrientationBuilder(builder: (context, orientation) {
            return Column(
              children: [
                // StreamBuilder(
                //   stream: StreamSocket.instance.getResponse,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       return Center(
                //         child: Text(
                //           'An Unexpected Error Has Occurred',
                //           style: TextConstants.mainTextStyle(
                //             textColor: Colors.redAccent,
                //             fontSize: 32,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       );
                //     } else if (snapshot.hasData) {
                //       late Widget child;
                //       switch (snapshot.data) {
                //         case WebSocketConstants.showOrderAccepted:
                //           child = Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               // SvgPicture.string(
                //               //   SvgConstants.chefSvg,
                //               //   height: orientation == Orientation.portrait
                //               //       ? deviceHeight * 0.3
                //               //       : null,
                //               //   width: orientation == Orientation.landscape
                //               //       ? deviceWidth * 0.3
                //               //       : null,
                //               // ),
                //               // SizedBox(
                //               //   height: 30,
                //               // ),
                //               Text(
                //                 'Our chefs have accepted your order!',
                //                 style:
                //                     TextConstants.mainTextStyle(fontSize: 32),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ],
                //           );
                //           break;
                //
                //         case WebSocketConstants.showOrderPrepared:
                //           child = Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               // SvgPicture.string(
                //               //   SvgConstants.waiterDeliveringSvg,
                //               //   height: orientation == Orientation.portrait
                //               //       ? deviceHeight * 0.3
                //               //       : null,
                //               //   width: orientation == Orientation.landscape
                //               //       ? deviceWidth * 0.3
                //               //       : null,
                //               // ),
                //               // SizedBox(
                //               //   height: 30,
                //               // ),
                //               Text(
                //                 'You\'re meals has been prepared\nA waiter will deliver them to you shortly!',
                //                 style:
                //                     TextConstants.mainTextStyle(fontSize: 32),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ],
                //           );
                //           break;
                //
                //         default:
                //           child = Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               // SvgPicture.string(
                //               //   SvgConstants.waiterSvg,
                //               //   height: orientation == Orientation.portrait
                //               //       ? deviceHeight * 0.3
                //               //       : null,
                //               //   width: orientation == Orientation.landscape
                //               //       ? deviceWidth * 0.3
                //               //       : null,
                //               // ),
                //               // SizedBox(
                //               //   height: 30,
                //               // ),
                //               Text(
                //                 'The Waiter will notify the kitchen\nabout your order!',
                //                 style:
                //                     TextConstants.mainTextStyle(fontSize: 32),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ],
                //           );
                //           break;
                //       }
                //       return child;
                //     } else {
                //       return Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // SvgPicture.string(
                //           //   SvgConstants.waiterSvg,
                //           //   height: orientation == Orientation.portrait
                //           //       ? deviceHeight * 0.3
                //           //       : null,
                //           //   width: orientation == Orientation.landscape
                //           //       ? deviceWidth * 0.3
                //           //       : null,
                //           // ),
                //           // SizedBox(
                //           //   height: 30,
                //           // ),
                //           Text(
                //             'The Waiter will notify the kitchen\nabout your order!',
                //             style: TextConstants.mainTextStyle(fontSize: 32),
                //             textAlign: TextAlign.center,
                //           ),
                //         ],
                //       );
                //     }
                //   },
                // ),
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
                    child: Obx(
                      () => Column(
                        children: OrderDataController
                            .instance.listenableOrderList
                            .asMap()
                            .entries
                            .map((entry) {
                          int key = entry.key;
                          Order order = entry.value;
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
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
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order #${key + 1}',
                                      style: TextConstants.mainTextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    Visibility(
                                      visible: order.status == OrderStatus.Editing,
                                      child: ActionButton(
                                        title: 'Complete Order',
                                        onPressed: () async {
                                          await WaitingScreenStateController.instance
                                              .completeOrder(order: order);
                                        },
                                        width: 200,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: order.orderItems
                                      .map(
                                        (orderItem) => OrderItemTile(
                                          orderItem: orderItem,
                                          onEditPressed: () {
                                            VmisStateController.instance
                                                .initByOrderItem(
                                                    orderItem: orderItem);
                                            Get.to(
                                              () => ViewMenuItemScreen(
                                                menuItem: orderItem.menuItem,
                                              ),
                                            );
                                          },
                                          onDeletePressed: () {
                                            WaitingScreenStateController
                                                .instance
                                                .removeOrderItem(
                                                    menuItemId:
                                                        orderItem.menuItem.id);
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
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
                            Obx(() {
                              double totalAmount = WaitingScreenStateController
                                  .instance.totalAmount;
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: Offset(0.0, -5.0),
                                        child: Text(
                                          '\$',
                                          style: TextConstants.subTextStyle(
                                            fontSize: 20,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: totalAmount.toStringAsFixed(2),
                                      style: TextConstants.subTextStyle(
                                        fontSize: 30,
                                        textColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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
