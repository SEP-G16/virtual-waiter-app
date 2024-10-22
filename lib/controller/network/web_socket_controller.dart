import 'dart:convert';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:virtual_waiter/constants/network_constants.dart';
import 'package:virtual_waiter/constants/web_socket_constants.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';
import 'package:virtual_waiter/enums/menu_item_status.dart';
import 'package:virtual_waiter/enums/order_status.dart';

import '../data/stream_socket_controller.dart';

class WebSocketController extends GetxController {
  static WebSocketController instance = Get.find();

  late SIO.Socket _socket;

  final StreamSocket _streamSocket = StreamSocket.instance;

  WebSocketController._();

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    try {
      _socket = SIO.io(NetworkConstants.baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'path': '/ws',
      });

      _socket.connect();

      _socket.on(WebSocketConstants.showOrderAccepted, (data) {
        Map<String, dynamic> dataMap = jsonDecode(data);
        bool isCorrectTable = TableDataController.instance.validateTable(tableId: dataMap['tableId']);
        bool isOnWaitingMode = TableDataController.instance.waitingMode;
        if(isCorrectTable && isOnWaitingMode)
          {
            _streamSocket.addResponse(WebSocketConstants.showOrderAccepted);
          }
      });

      _socket.on(WebSocketConstants.showOrderPrepared, (data) {
        Map<String, dynamic> dataMap = jsonDecode(data);
        bool isCorrectTable = TableDataController.instance.validateTable(tableId: dataMap['tableId']);
        bool isOnWaitingMode = TableDataController.instance.waitingMode;
        if(isCorrectTable && isOnWaitingMode)
        {
          _streamSocket.addResponse(WebSocketConstants.showOrderPrepared);
        }
      });

      _socket.on("readOrderStatusUpdate", (data) {
        Map<String, dynamic> dataMap = jsonDecode(data);
        print(dataMap);
        bool isCorrectTable = TableDataController.instance.validateTable(tableId: (dataMap['table']!['id']! as int));
        if(isCorrectTable)
          {
            OrderDataController.instance.updateOrderItemStatus(orderMap: dataMap);
          }
      });

      _socket.on("readUpdateMenuItemStatus", (data){
        Map<String, dynamic> menuItemMap = jsonDecode(data);
        int id = menuItemMap['id'];
        MenuItemStatus status = MenuItemStatus.fromString(menuItemMap['status']);

        MenuDataController.instance.updateMenuItemStatus(id: id, status: status);

        OrderDataController.instance.updateOrderDueToManyItemStatusChange(menuItemId : id, menuItemStatus : status);
      });
    } catch (e) {
      print('Error establishing websocket connection.');
      rethrow;
    }
  }

  Future<void> sendHelpRequest() async {
    try {
      _socket.emit(
        WebSocketConstants.onHelpRequest,
        jsonEncode(
          {
            'tableId': TableDataController.instance.table.id,
            'tableNo': TableDataController.instance.table.tableNo,
          },
        ),
      );
    } catch (e) {
      print('Error sending help request');
      rethrow;
    }
  }

  Future<void> sendReadyToPayMessage() async {
    try {
      print("Called");
      _socket.emit(
        'onReadyToPay',
        jsonEncode(
          {
            'tableId': TableDataController.instance.table.id,
            'tableNo': TableDataController.instance.table.tableNo,
          },
        ),
      );
    } catch (e) {
      print('Error sending help request');
      rethrow;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _socket.connect();
    super.onInit();
  }
}
