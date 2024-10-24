import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/controller/data/preferences_controller.dart';
import 'package:virtual_waiter/controller/data/stream_socket_controller.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';
import 'package:virtual_waiter/controller/network/menu_data_network_controller.dart';
import 'package:virtual_waiter/controller/network/order_data_network_controller.dart';
import 'package:virtual_waiter/controller/network/table_network_controller.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';
import 'package:virtual_waiter/controller/views/menu_screen/menu_widget_tree_builder.dart';
import 'package:virtual_waiter/controller/views/order_screen/order_screen_state_controller.dart';
import 'package:virtual_waiter/controller/views/view_menu_item_screen/vmis_state_controller.dart';
import 'package:virtual_waiter/controller/views/welcome_screen_controller.dart';

class ControllerInitializer{
  static bool _initialized = false;

  static bool get initialized => _initialized;

  static Future<void> initAllControllers() async {
    try{
      Get.deleteAll();

      final prefCont = Get.put(PreferencesController());
      await prefCont.setPreference('tableId', 1);

      Get.put(TableNetworkController());
      final tableDataController = Get.put(TableDataController());

      await tableDataController.initialize();

      Get.put(StreamSocket());
      await Get.putAsync(() => WebSocketController.create());

      Get.put(MenuDataNetworkController());
      await Get.putAsync(() => MenuDataController.create());

      Get.put(OrderDataNetworkController());
      await Get.putAsync(() => OrderDataController.create());

      Get.put(OrderItemDataController());
      Get.put(OssController());
      Get.put(VmisStateController());
      Get.put(MenuWidgetTreeBuilder());

      Get.put(WelcomeScreenController());

      _initialized = true;
    }catch(e){
      print('Error occurred while initialising controllers! ${e}');
      _initialized = false;
      rethrow;
    }
  }
}