import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/controller/views/view_menu_item_screen/vmis_state_controller.dart';
import 'package:virtual_waiter/enums/menu_item_status.dart';
import 'package:virtual_waiter/model/menu_item.dart';
import 'package:virtual_waiter/views/view_menu_item_screen.dart';

class MenuWidgetTreeBuilder extends GetxController {
  RxList<Widget> _widgetList = <Widget>[].obs;

  List<Widget> get widgetList => _widgetList;

  final MenuDataController _menuDataController = MenuDataController.instance;

  final VmisStateController _vmisStateController = VmisStateController.instance;

  final OrderItemDataController _orderDataController =
      OrderItemDataController.instance;

  static MenuWidgetTreeBuilder instance = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _buildMenuWidgetTree();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    debounce(
        _menuDataController.menuChangedListener, (_) => _buildMenuWidgetTree());
  }

  void _buildMenuWidgetTree() {
    _widgetList.clear();
    Map<String, List<MenuItem>> menuItemMap =
        _menuDataController.menuItemOrderedMap;
    for (var entry in menuItemMap.entries) {
      String category = entry.key;
      List<MenuItem> items = entry.value;

      bool allAreOutOfStock = menuItemMap[category]!
          .every((menuItem) => menuItem.status == MenuItemStatus.OutOfStock);

      if (!allAreOutOfStock) {
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
          if (item.status == MenuItemStatus.InStock) {
            _widgetList.add(
              MenuItemTile(
                item: item,
                onPressed: () {
                  if (_orderDataController.orderItemAlreadyExists(
                      menuItemId: item.id)) {
                    _vmisStateController.initByOrderItem(
                        orderItem:
                            _orderDataController.findByMenuItemId(id: item.id));
                  } else {
                    _vmisStateController.menuItem = item;
                  }
                  //setting menu item here instead of setting it in the ViewMenuItemScreen
                  Get.to(
                    () => ViewMenuItemScreen(
                      menuItem: item,
                    ),
                  );
                },
              ),
            );
          }
        }
      }
    }
  }
}
