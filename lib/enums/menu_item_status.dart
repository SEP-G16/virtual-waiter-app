enum MenuItemStatus{
  InStock, OutOfStock;

  static MenuItemStatus fromString(String status){
    switch(status){
      case 'InStock':
        return MenuItemStatus.InStock;
      case 'OutOfStock':
        return MenuItemStatus.OutOfStock;
      default:
        throw Exception('Unknown menu item status');
    }
  }
}