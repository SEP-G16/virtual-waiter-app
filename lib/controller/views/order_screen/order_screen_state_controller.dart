import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/model/order_item.dart';

import '../../../model/menu_item.dart';
import '../../../model/order_menu_item.dart';
import '../../data/menu_data_controller.dart';

class OssController extends GetxController {
  final MenuDataController _mdc = MenuDataController.instance;
  final OrderDataController _odc = OrderDataController.instance;

  RxList<OrderMenuItem> _orderMenuItems = <OrderMenuItem>[].obs;
  List<OrderMenuItem> get orderMenuItems => _orderMenuItems.value;

  static OssController instance = Get.find();

  OrderMenuItem _generateOrderMenuItem({required OrderItem orderItem}) {
    MenuItem menuItem = _mdc.allItems
        .where((item) => item.id == orderItem.menuItemId)
        .toList()
        .first;

    List<String> addOnList = [];

    orderItem.addOnsQuantity.keys.forEach((addOnId) {
      addOnList.add(menuItem.addOns
          .where((addOn) => addOn['id'] == addOnId)
          .toList()
          .first['name']);
    });

    return OrderMenuItem(
      itemCategory: menuItem.category,
      menuItemId: menuItem.id,
      menuItemName : menuItem.name,
      menuItemImageUrl: menuItem.imageUrl,
      itemQuantity: orderItem.itemQuantity,
      addOnList: addOnList,
      totalAmount: orderItem.totalAmount,
    );
  }

  void analyseOrderData() {
    _orderMenuItems.value = [];
    _odc.orderList.forEach((order) {
      _orderMenuItems.add(_generateOrderMenuItem(orderItem: order));
      update();
    });
  }

  void removeOrderItem({required String menuItemId}){
    if(_orderMenuItems.value.any((order) => order.menuItemId == menuItemId))
      {
        _orderMenuItems.value.removeWhere((order) => order.menuItemId == menuItemId);
        update();
      }
  }
}
