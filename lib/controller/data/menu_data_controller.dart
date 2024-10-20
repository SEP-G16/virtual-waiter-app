import 'package:get/get.dart';
import 'package:virtual_waiter/components/message_dialog_box.dart';
import 'package:virtual_waiter/controller/network/menu_data_network_controller.dart';
import 'package:virtual_waiter/enums/menu_item_status.dart';

import '../../model/menu_item.dart';

class MenuDataController extends GetxController {
  Map<String, List<MenuItem>> _menuItemOrderedMap = {};

  Map<String, List<MenuItem>> get menuItemOrderedMap => _menuItemOrderedMap;

  List<MenuItem> _allItems = [];

  List<MenuItem> get allItems => _allItems;

  final MenuDataNetworkController _mdnc = MenuDataNetworkController.instance;
  static MenuDataController instance = Get.find();

  MenuDataController._();

  RxInt _menuChangedListener = 0.obs;

  RxInt get menuChangedListener => _menuChangedListener;

  static Future<MenuDataController> create() async {
    MenuDataController controller = MenuDataController._();
    await controller._initControllerData();
    return controller;
  }

  Future<void> _initControllerData() async {
    await _getMenuData();
  }

  Future<void> _getMenuData() async {
    List<Map<String, dynamic>> menuData = await _mdnc.getMenuData();
    _menuItemOrderedMap.clear();
    _allItems.clear();

    for (var item in menuData) {
      MenuItem menuItem = MenuItem.fromMap(item);
      _allItems.add(menuItem);
      _menuItemOrderedMap
          .putIfAbsent(menuItem.category.name, () => [])
          .add(menuItem);
    }

    _menuItemOrderedMap.forEach((category, items) {
      items.sort((a, b) => a.name.compareTo(b.name));
    });

    _menuChangedListener.update((val) => val! + 1);
  }

  MenuItem findItemById({required int id}) {
    if (_allItems.any((item) => item.id == id)) {
      return _allItems.where((item) => item.id == id).toList().first;
    } else {
      throw Exception('Item Not Found');
    }
  }

  void updateMenuItemStatus({required int id, required MenuItemStatus status}) {
    MenuItem item = findItemById(id: id);
    _allItems[_allItems.indexOf(item)] = item.copyWith(status: status);
    _menuItemOrderedMap[item.category.name] =
        _menuItemOrderedMap[item.category.name]!
            .map((menuItem) => menuItem.id == id ? item : menuItem)
            .toList();

    bool allAreOutOfStock = _menuItemOrderedMap[item.category.name]!
        .every((menuItem) => menuItem.status == MenuItemStatus.OutOfStock);

    if (allAreOutOfStock) {
      _menuItemOrderedMap.remove(item.category.name);
    }

    if (status == MenuItemStatus.OutOfStock) {
      MessageDialogBox(
        message:
            'Oops! It looks like ${item.name} is now out of stock.\nAny pending orders with this item will be rejected.\nWe apologize for the inconvenience\nand appreciate your understanding!',
      );
    }
  }
}
