import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/model/menu_item.dart';
import 'package:virtual_waiter/model/order_item.dart';

//vmis -view menu item screen
class VmisStateController extends GetxController {
  static VmisStateController instance = Get.find();

  final OrderDataController _orderDataController = OrderDataController.instance;

  Map<String, int> _selectedAddOnsDataMap = {};
  Map<String, RxInt> _selectedAddOnsQuantityMap = {};

  MenuItem? _menuItem;
  MenuItem get menuItem => _menuItem!;
  set menuItem(MenuItem item) {
    _menuItem = item;
    _selectedAddOnsDataMap = {};
    _selectedAddOnsQuantityMap = {};
    _totalAmount.value = item.price;
  }

  RxInt _quantity = 1.obs;
  int get quantity => _quantity.value;
  set quantity(int newQuantity) {
    _quantity.value = quantity;
    update();
  }

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  String? _additionalNotes = '';
  String? get additionalNotes => _additionalNotes;
  set additionalNotes(String? value) => _additionalNotes = value;

  void itemNotNullCheck() {
    if (_menuItem == null) {
      throw Exception('MenuItem menuItem is null');
    }
  }

  void incrementQuantity() {
    itemNotNullCheck();
    int curr = _quantity.value;
    curr++;
    _quantity.value = curr;
    _calculateTotal();
    update();
  }

  void decrementQuantity() {
    itemNotNullCheck();
    int curr = _quantity.value;

    for (String addOnId in _selectedAddOnsQuantityMap.keys) {
      int addOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
      if (curr > 1 && curr == addOnQuantity) {
        addOnQuantity--;
        _selectedAddOnsQuantityMap[addOnId]!.value = addOnQuantity;
      }
    }

    if (curr > 1) {
      curr--;
      _quantity.value = curr;
    }
    _calculateTotal();
    update();
  }

  void resetData() {
    _menuItem = null;
    _quantity.value = 1;
    _selectedAddOnsQuantityMap = {};
    _selectedAddOnsDataMap = {};
    _totalAmount.value = 0;
  }

  void addAddOnToDataMap({required String addOnId}) {
    itemNotNullCheck();
    _selectedAddOnsQuantityMap[addOnId] = 1.obs;
    _calculateTotal();
  }

  void removeAddOnFromDataMap({required String addOnId}) {
    itemNotNullCheck();
    _selectedAddOnsQuantityMap.remove(addOnId);
    _calculateTotal();
  }

  void incrementAddOnQuantity({required String addOnId}) {
    itemNotNullCheck();
    int currAddOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
    if (currAddOnQuantity < _quantity.value) {
      currAddOnQuantity++;
      _selectedAddOnsQuantityMap[addOnId]!.value = currAddOnQuantity;
      _calculateTotal();
      update();
    }
  }

  void decrementAddOnQuantity({required String addOnId}) {
    itemNotNullCheck();
    int currAddOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
    if (currAddOnQuantity > 1) {
      currAddOnQuantity--;
      _selectedAddOnsQuantityMap[addOnId]!.value = currAddOnQuantity;
      _calculateTotal();
      update();
    }
  }

  int getAddOnQuantityValue({required String addOnId}) {
    return _selectedAddOnsQuantityMap[addOnId]!.value;
  }

  void _calculateTotal() {
    itemNotNullCheck();
    double totalBasePrice = menuItem.price * _quantity.value;
    double totalAddOnPrice = 0.0;
    for (String addOnId in _selectedAddOnsQuantityMap.keys) {
      int addOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
      double addOnPrice = menuItem.addOns
          .where((addOn) => addOn['id'] == addOnId)
          .toList()
          .first['price'];
      totalAddOnPrice += addOnQuantity * addOnPrice;
    }
    _totalAmount.value = totalAddOnPrice + totalBasePrice;
  }

  void addOrder() {
    itemNotNullCheck();
    for (var entry in _selectedAddOnsQuantityMap.entries) {
      String addOnId = entry.key;
      int addOnQuantity = entry.value.value;
      _selectedAddOnsDataMap[addOnId] = addOnQuantity;
    }
    _orderDataController.addOrderItem(
      orderItem: OrderItem(
        menuItemId: menuItem.id,
        itemQuantity: _quantity.value,
        addOnsQuantity: _selectedAddOnsDataMap,
        additionalNote: _additionalNotes,
        totalAmount: totalAmount,
      ),
    );
  }
}
