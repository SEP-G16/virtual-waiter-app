import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/components/order_item_tile.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';
import 'package:virtual_waiter/controller/views/order_screen/order_screen_state_controller.dart';
import 'package:virtual_waiter/controller/views/view_menu_item_screen/vmis_state_controller.dart';
import 'package:virtual_waiter/views/view_menu_item_screen.dart';
import 'package:virtual_waiter/views/waiting_screen.dart';

import '../model/order_item.dart';

class OrderScreen {
  OrderScreen() {
    _showOrderScreen();
  }

  final OssController _ossController = OssController.instance;

  void _showOrderScreen() {
    _ossController.analyseOrderData();
    Get.dialog(Dialog(
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        double deviceHeight = MediaQuery.of(context).size.height;
        return Container(
          height: isLandscape ? double.infinity : deviceHeight * 0.6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(20.0),
          child: GetBuilder<OssController>(builder: (cont) {
            bool isOrderEmpty = cont.orderItems.isEmpty;
            return isOrderEmpty
                ? Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 30,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'My Order',
                              style: TextConstants.mainTextStyle(fontSize: 32),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'What are you going to have today?',
                            textAlign: TextAlign.center,
                            style: TextConstants.mainTextStyle(),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 30,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'My Order',
                              style: TextConstants.mainTextStyle(fontSize: 32),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: _ossController.orderItems
                                .map(
                                  (item) => OrderItemTile(
                                    orderItem: item,
                                    onEditPressed: () {
                                      VmisStateController.instance.initByOrderItem(orderItem: item);
                                      Get.to(() =>
                                        ViewMenuItemScreen(
                                          menuItem: item.menuItem,
                                        ),
                                      );
                                    },
                                    onDeletePressed: () {
                                      cont.removeOrderItem(
                                          menuItemId: item.menuItem.id);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                MdiIcons.cashMultiple,
                                size: 35,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Total',
                                style: TextConstants.mainTextStyle(
                                    fontSize: 32),
                              ),
                            ],
                          ),
                          Obx(
                                () => RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: Offset(0, -2),
                                    child: Text(
                                      '\$',
                                      style: TextConstants.subTextStyle(
                                          fontSize: 24),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: _ossController.totalAmount
                                      .toStringAsFixed(2),
                                  style: TextConstants.subTextStyle(
                                      fontSize: 32,
                                      textColor: Colors.black),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 8,
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      Divider(
                        height: 3,
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10.0,),
                      ActionButton(
                        title: 'Complete Order',
                        onPressed: () async {
                          try{
                            await _ossController.completeOrder();
                            Get.back();
                            TableDataController.instance.waitingMode = true;
                            Get.offAll(() => WaitingScreen());
                          }catch(e){
                            //Add error dialog here
                            print(e.toString());
                          }
                        },
                        width: 250,
                      ),
                    ],
                  );
          }),
        );
      }),
    ), barrierDismissible: true);
  }
}
