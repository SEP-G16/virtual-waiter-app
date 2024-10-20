class RestaurantTable{
  int id;
  int tableNo;

  RestaurantTable({required this.id, required this.tableNo});

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'tableNo': tableNo,
    };
  }

  factory RestaurantTable.fromMap(Map<String, dynamic> tableData) {
    return RestaurantTable(
      id: tableData['id'],
      tableNo: tableData['tableNo'],
    );
  }
}