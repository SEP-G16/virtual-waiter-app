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
}
