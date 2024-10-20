import 'package:get/get.dart';
import 'package:virtual_waiter/components/order_more_or_leave_dialog.dart';
import 'package:virtual_waiter/components/order_more_or_pay_dialog.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/model/order.dart';

import '../../enums/order_status.dart';
import '../../model/order_item.dart';

class WaitingScreenStateController extends GetxController {
  RxBool snackBarDisplayed = false.obs;
  RxBool dialogDisplayed = false.obs;

  static WaitingScreenStateController instance = Get.find();

  final OrderDataController _odc = OrderDataController.instance;

  final OrderItemDataController _oidc = OrderItemDataController.instance;

  RxList<Order> _orderList = <Order>[].obs;

  List<Order> get orderList => _orderList;

  RxList<Order> get listenableOrderList => _orderList;

  RxDouble _totalAmount = 0.0.obs;

  double get totalAmount => _totalAmount.value;

  void calculateTotalAmount() {
    double total = 0.0;
    for (Order order in _orderList) {
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

  void removeOrderItem({required int menuItemId}) {
    _oidc.removeOrderItem(menuItemId: menuItemId);
  }

  void _dialogHandler(List<Order> list) {
    if (list.isEmpty) {
      return;
    }

    bool anyPending = list.any((order) {
      return order.status == OrderStatus.Pending;
    });

    bool anyProcessing = list.any((order) {
      return order.status == OrderStatus.Processing;
    });

    bool everyRejected = list.every((order) {
      return order.status == OrderStatus.Cancelled;
    });

    bool anyEditing = list.any((order) {
      return order.status == OrderStatus.Editing;
    });

    bool eitherCompleteOrCancelled = list.every((order) =>
        order.status == OrderStatus.Complete ||
        order.status == OrderStatus.Cancelled);

    if (!anyPending && !anyProcessing && !anyEditing) {
      if (everyRejected) {
        //TODO: handle reject case
        OrderMoreOrLeaveDialog();
      } else {
        if (eitherCompleteOrCancelled) {
          return;
        }
        OrderMoreOrPayDialog();
      }
    }
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
    debounce(_odc.listenableOrderList, (List<Order> orders) {
      _orderList.assignAll(orders);
      calculateTotalAmount();
      _dialogHandler(orders);
    });
  }

  Future<void> completeOrder({required Order order}) async {
    await _odc.completeOrder();
  }

  void showPaymentDialogIfComplete() {
    List<Order> list = _orderList;
    _dialogHandler(list);
  }

  void resetController() {
    _orderList.clear();
    _totalAmount.value = 0.0;
  }
}
