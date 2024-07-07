import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/views/menu_screen/menu_widget_tree_builder.dart';

import 'order_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Icon(Icons.menu),
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
                    child: GestureDetector(
                        onTap: (){
                          OrderScreen();
                        },
                        child: Icon(Icons.room_service_outlined)),
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
