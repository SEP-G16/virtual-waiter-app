import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

import '../enums/order_status.dart';
import 'order_item.dart';

class Order {
  int id;
  List<OrderItem> orderItems;
  OrderStatus _status = OrderStatus.Editing;
  String sessionId;

  Order(
      {required this.id,
      required this.orderItems,
      required OrderStatus status,
      required this.sessionId}) {
    _status = status;
  }

  OrderStatus get status => _status;

  set status(OrderStatus status) => _status = status;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderItems': orderItems.map((orderItem) => orderItem.toMap()).toList(),
      'sessionId': sessionId,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map, List<OrderItem> orderItems) {
    return Order(
      id: map['id'],
      orderItems: orderItems,
      status: OrderStatus.fromString(map['status']),
      sessionId: map['sessionId'],
    );
  }

  Order copyWith(
      {int? id,
      List<OrderItem>? orderItems,
      OrderStatus? status,
      String? sessionId}) {
    return Order(
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      status: status ?? this._status,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}
