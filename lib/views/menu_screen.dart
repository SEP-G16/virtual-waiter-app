import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/views/menu_screen/menu_widget_tree_builder.dart';
import 'package:virtual_waiter/enums/order_status.dart';
import 'package:virtual_waiter/views/waiting_screen.dart';

import 'configure_screen.dart';
import 'order_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Container(
          width: 400,
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ActionButton(
              //   title: 'Settings',
              //   onPressed: () {},
              // ),
              Text(
                'Welcome to Virtual Waiter',
                style: TextConstants.mainTextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () => Get.to(() => ConfigureScreen()),
                child: Container(
                  width: 230,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.amber,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Settings',
                        style: TextConstants.subTextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      //TODO:Create Drawer to have settings option
      // drawer: Drawer(
      //   child: Text('Drawer'),
      // ),
      // drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Builder(builder: (context) {
                      return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(Icons.menu));
                    }),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Menu',
                        style: TextConstants.mainTextStyle(fontSize: 32),
                      ),
                      Text(
                        'Choose your favourite meals',
                        style: TextConstants.subTextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Obx(() {
                      bool onlyEditableOrder = OrderDataController
                          .instance.listenableOrderList.length == 1 && OrderDataController
                          .instance.listenableOrderList.first.status == OrderStatus.Editing;

                      bool noItemsHaveBeenAddedYet = OrderDataController
                          .instance.listenableOrderList.isEmpty;

                      return GestureDetector(
                          onTap: () {
                            onlyEditableOrder || noItemsHaveBeenAddedYet
                                ? OrderScreen()
                                : Get.to(() => WaitingScreen());
                          },
                          child: Icon(Icons.room_service_outlined));
                    }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: MenuWidgetTreeBuilder.instance.widgetList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
