import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_waiter/components/order_item_tile.dart';
import 'package:virtual_waiter/constants/svg_constants.dart';
import 'package:virtual_waiter/controller/views/payment_screen_state_controller.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/enums/order_status.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:get/get.dart';

import '../components/action_button.dart';
import '../constants/text_constants.dart';
import '../model/order.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentScreenStateController());

    Widget _buildOrderList() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              'Meals you ordered',
              style: TextConstants.subTextStyle(fontSize: 24),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: PaymentScreenStateController
                        .instance.pendingPaymentOrderList
                        .where((order) =>
                            order.status == OrderStatus.Pending_Payment)
                        .map((order) {
                      List<OrderItem> orderItems = order.orderItems;
                      return Column(
                        children: orderItems
                            .where((orderItem) =>
                                orderItem.status == OrderItemStatus.Complete)
                            .map(
                              (orderItem) => OrderItemTile(
                                orderItem: orderItem,
                                pendingPaymentMode: true,
                              ),
                            )
                            .toList(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: List.generate(
            //         5,
            //         (_) => Container(
            //           margin: EdgeInsets.symmetric(vertical: 10),
            //           height: 20,
            //           width: 200,
            //           color: Colors.amber,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black.withOpacity(0.7),
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextConstants.mainTextStyle(fontSize: 36),
                        ),
                        Obx(() {
                          double totalAmount = PaymentScreenStateController.instance.totalAmount;
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
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black.withOpacity(0.7),
                    thickness: 1,
                    height: 5,
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black.withOpacity(0.7),
                    thickness: 1,
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Column(
                children: [
                  Text(
                    'Let\'s Settle The Bill',
                    style: TextConstants.mainTextStyle(),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.string(
                                SvgConstants.waiterWritingSvg,
                                height: 200,
                              ),
                              Text(
                                'A Waiter will come with your bill shortly.',
                                style: TextConstants.subTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: _buildOrderList(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
