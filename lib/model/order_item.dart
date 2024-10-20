import 'package:virtual_waiter/model/menu_item.dart';
import 'package:virtual_waiter/model/selected_add_on.dart';

import '../enums/order_item_status.dart';

class OrderItem {
  final int id;
  final MenuItem menuItem;
  final int itemQuantity;
  final List<SelectedAddOn> selectedAddOns;
  String? additionalNote;
  final double totalAmount;
  OrderItemStatus _status = OrderItemStatus.Editing;

  OrderItem({
    required this.id,
    required this.menuItem,
    required this.itemQuantity,
    required this.selectedAddOns,
    this.additionalNote,
    required this.totalAmount,
    required OrderItemStatus status,
  }) : _status = status;

  OrderItemStatus get status => _status;
  set status(OrderItemStatus status) => _status = status;

  OrderItem copyWith({
    int? id,
    MenuItem? menuItem,
    int? itemQuantity,
    List<SelectedAddOn>? selectedAddOns,
    String? additionalNote,
    double? totalAmount,
    OrderItemStatus? status,
  }) {
    return OrderItem(
      id: id ?? this.id,
      menuItem: menuItem ?? this.menuItem,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      additionalNote: additionalNote ?? this.additionalNote,
      totalAmount: totalAmount ?? this.totalAmount, status: status ?? OrderItemStatus.Editing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'menuItem': menuItem.toMap(),
      'quantity': itemQuantity,
      'addOns': selectedAddOns.map((x) => x.toMap()).toList(),
      'additionalNotes': additionalNote,
      'totalAmount': totalAmount,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map, MenuItem menuItem, List<SelectedAddOn> addOns) {
    return OrderItem(
      id: map['id'],
      menuItem: menuItem,
      itemQuantity: map['quantity'],
      selectedAddOns: addOns,
      additionalNote: map['additionalNotes'],
      totalAmount: map['totalAmount'],
      status: OrderItemStatus.fromString(map['status']),
    );
  }
}
