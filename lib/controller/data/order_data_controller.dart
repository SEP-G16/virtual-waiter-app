import 'package:get/get.dart';

import '../../model/order_item.dart';

class OrderDataController extends GetxController{
  static OrderDataController instance = Get.find();

  List<OrderItem> _orderList = [];

  void addOrderItem({required OrderItem orderItem}){
    _orderList.add(orderItem);
    _orderList.forEach((order) => print(order.toString()));
  }

}
