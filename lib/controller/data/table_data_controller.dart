import 'package:get/get.dart';


//Need to implement this with shared_preferences
class TableDataController extends GetxController{

  static TableDataController instance = Get.find();
  String _tableId = '12';
  String get tableId => _tableId;

  int _tableNo = 12;
  int get tableNo => _tableNo;

  bool _waitingMode = false;
  bool get waitingMode => _waitingMode;
  set waitingMode(value) => _waitingMode = value;

  bool validateTable({required String tableId}){
    return tableId == _tableId;
  }
}