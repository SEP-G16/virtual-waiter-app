class OrderItem {
  final String menuItemId;
  final int itemQuantity;
  final Map<String, int> addOnsQuantity;
  String? additionalNote;
  final double totalAmount;

  OrderItem({
    required this.menuItemId,
    required this.itemQuantity,
    required this.addOnsQuantity,
    this.additionalNote,
    required this.totalAmount,
  });

  @override
  String toString() {
    return 'OrderItem{menuItemId: $menuItemId, itemQuantity: $itemQuantity, addOnsQuantity: $addOnsQuantity, additionalNote: $additionalNote, totalAmount: $totalAmount}';
  }

  OrderItem copyWith({
    String? menuItemId,
    int? itemQuantity,
    Map<String, int>? addOnsQuantity,
    String? additionalNote,
    double? totalAmount,
  }) {
    return OrderItem(
      menuItemId: menuItemId ?? this.menuItemId,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      addOnsQuantity: addOnsQuantity ?? this.addOnsQuantity,
      additionalNote: additionalNote ?? this.additionalNote,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menuItemId': menuItemId,
      'itemQuantity': itemQuantity,
      'addOnsQuantity': addOnsQuantity,
      'additionalNote': additionalNote,
      'totalAmount': totalAmount,
    };
  }

}
