import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/model/order.dart';

import '../../model/order_item.dart';

class WaitingScreenStateController extends GetxController{

  static WaitingScreenStateController instance = Get.find();

  final OrderDataController _odc = OrderDataController.instance;

  final OrderItemDataController _oidc = OrderItemDataController.instance;

  RxList<Order> _orderList = <Order>[].obs;
  List<Order> get orderList => _orderList;

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  void calculateTotalAmount()
  {
    double total = 0.0;
    for(Order order in _orderList)
    {
      total += order.orderItems.fold(0, (previousValue, element) => previousValue + element.totalAmount);
    }
    _totalAmount.value = total;
  }

  void removeOrderItem({required int menuItemId}){
    _oidc.removeOrderItem(menuItemId: menuItemId);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _orderList.assignAll(_odc.orderList);
    calculateTotalAmount();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_odc.listenableOrderList, (List<Order> orders){
      _orderList.assignAll(orders);
      calculateTotalAmount();
    });
  }

  Future<void> completeOrder({required Order order}) async{
    await _odc.completeOrder();
  }
}
