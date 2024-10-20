import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';
import 'package:virtual_waiter/controller/views/waiting_screen_state_controller.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/enums/order_status.dart';
import 'package:virtual_waiter/views/loading_screen.dart';

import '../../model/order.dart';

class PaymentScreenStateController extends GetxController {
  static PaymentScreenStateController instance = Get.find();

  final OrderDataController _odc = OrderDataController.instance;

  RxList<Order> _pendingPaymentOrderList = <Order>[].obs;

  List<Order> get pendingPaymentOrderList => _pendingPaymentOrderList;

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  void _calculateTotalAmount() {
    double total = 0.0;
    for (Order order in _pendingPaymentOrderList) {
      total += order.orderItems.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (element.status != OrderItemStatus.Rejected
                ? element.totalAmount
                : 0),
      );
    }
    _totalAmount.value = total;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (_odc.orderList.every((order) =>
        order.status == OrderStatus.Pending_Payment ||
        order.status == OrderStatus.Cancelled)) {
      _pendingPaymentOrderList.assignAll(_odc.orderList
          .where((order) => order.status == OrderStatus.Pending_Payment)
          .toList());

      _calculateTotalAmount();
    } else {
      throw Exception('All orders are not complete');
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    debounce(_odc.listenableOrderList, (list) async {
      if (list.every((order) =>
          order.status == OrderStatus.Pending_Payment ||
          order.status == OrderStatus.Cancelled)) {
        _pendingPaymentOrderList.assignAll(list
            .where((order) => order.status == OrderStatus.Pending_Payment)
            .toList());

        _calculateTotalAmount();
      } else if(
      list.every((order) =>
      order.status == OrderStatus.Complete ||
          order.status == OrderStatus.Cancelled)
      ){
        OrderItemDataController.instance.resetList();
        await OrderDataController.instance.resetOrderList();
        Get.offAll(() => LoadingScreen());
      }
      // else {
      //   throw Exception('All orders are not complete');
      // }
    });
  }

  void resetController() {
    _pendingPaymentOrderList.clear();
    _totalAmount.value = 0.0;
  }
}
