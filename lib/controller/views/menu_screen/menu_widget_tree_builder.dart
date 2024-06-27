import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/model/menu_item.dart';

class MenuWidgetTreeBuilder extends GetxController {
  List<Widget> _widgetList = [];
  List<Widget> get widgetList => _widgetList;

  final MenuDataController _menuDataController = MenuDataController.instance;

  static MenuWidgetTreeBuilder instance = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _buildMenuWidgetTree();
  }

  void _buildMenuWidgetTree() {
    _widgetList.clear();
    Map<String, List<MenuItem>> menuItemMap =
        _menuDataController.menuItemOrderedMap;
    for (var entry in menuItemMap.entries) {
      String category = entry.key;
      List<MenuItem> items = entry.value;
      _widgetList.add(Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.black,
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Text(
                category,
                style: TextConstants.subTextStyle(fontSize: 20),
              ),
            ),
            const Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.black,
                height: 10,
              ),
            ),
          ],
        ),
      ));
      for (MenuItem item in items) {
        _widgetList.add(
          MenuItemTile(
            item: item,
            onPressed: () {},
          ),
        );
      }
    }
  }
}
