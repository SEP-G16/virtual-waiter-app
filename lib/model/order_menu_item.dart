class OrderMenuItem {
  final String itemCategory;
  final String menuItemId;
  final String menuItemName;
  final String menuItemImageUrl;
  final int itemQuantity;
  final List<String> addOnList;
  final double totalAmount;

  OrderMenuItem({
    required this.menuItemId,
    required this.menuItemImageUrl,
    required this.itemQuantity,
    required this.addOnList,
    required this.totalAmount,
    required this.menuItemName,
    required this.itemCategory,
  });

}
