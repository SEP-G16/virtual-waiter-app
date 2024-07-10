import 'dart:convert';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:virtual_waiter/constants/network_constants.dart';
import 'package:virtual_waiter/constants/web_socket_constants.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';

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
            'tableId': TableDataController.instance.tableId,
            'tableNo': TableDataController.instance.tableNo,
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
