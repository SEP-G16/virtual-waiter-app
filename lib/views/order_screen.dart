import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/components/order_tile.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';
import 'package:virtual_waiter/controller/views/order_screen/order_screen_state_controller.dart';

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
            bool isOrderEmpty = cont.orderMenuItems.isEmpty;
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
                            children: _ossController.orderMenuItems
                                .map(
                                  (item) => OrderTile(
                                    itemCategory: item.itemCategory,
                                    menuItemId: item.menuItemId,
                                    menuItemName: item.menuItemName,
                                    menuItemImageUrl: item.menuItemImageUrl,
                                    itemQuantity: item.itemQuantity,
                                    addOns: item.addOnList,
                                    totalAmount: item.totalAmount,
                                    onEditPressed: () {},
                                    onDeletePressed: () {
                                      cont.removeOrderItem(
                                          menuItemId: item.menuItemId);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      ActionButton(
                        title: 'Complete Order',
                        onPressed: () {},
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
