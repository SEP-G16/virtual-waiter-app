import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';

import '../../model/order_item.dart';

class OrderDataController extends GetxController{
  static OrderDataController instance = Get.find();

  List<OrderItem> _orderList = [];
  List<OrderItem> get orderList => _orderList;

  void addOrderItem({required OrderItem orderItem}){
    _orderList.add(orderItem);
  }

  void removeOrderItem({required String menuItemId}){
    _orderList.removeWhere((order) => order.menuItemId == menuItemId);
  }
}
