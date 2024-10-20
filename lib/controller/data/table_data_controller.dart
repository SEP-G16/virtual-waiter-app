import 'dart:convert';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_waiter/controller/data/preferences_controller.dart';
import 'package:virtual_waiter/controller/network/table_network_controller.dart';
import 'package:virtual_waiter/model/restaurant_table.dart';
import 'package:virtual_waiter/views/configure_screen.dart';

//Need to implement this with shared_preferences
class TableDataController extends GetxController {
  final PreferencesController _prefs = PreferencesController.instance;

  final TableNetworkController _tdnc = TableNetworkController.instance;

  static TableDataController instance = Get.find();

  RestaurantTable _table = RestaurantTable(id: 1, tableNo: 1);

  RestaurantTable get table => _table;

  bool _waitingMode = false;

  bool get waitingMode => _waitingMode;

  // set waitingMode(value) => _waitingMode = value;

  String? _sessionId = null;

  String? get sessionId => _sessionId;

  bool validateTable({required tableId}) {
    return table.id == tableId;
  }

  Future<void> configureTable(int scannedId) async {
    Map<String, dynamic> tableData = await _tdnc.getTableData(scannedId);
    _table = RestaurantTable.fromMap(tableData);
    _prefs.setPreference<int>('tableId', _table.id);
    await configureSessionData(_table.id);
  }

  Future<void> configureSessionData(int tableId) async {
    bool containsSessionData = await _prefs.containsKey('sessionData');
    if (containsSessionData) {
      String? sessionData = await _prefs.getPreference<String>('sessionData');
      Map<String, dynamic> decodedSessionData = jsonDecode(sessionData!);
      if (decodedSessionData['tableId']! == tableId) {
        _sessionId = decodedSessionData['sessionId']!;
      } else {
        _sessionId = null;
        await _prefs.removePreference('sessionData');
      }
    }
  }

  Future<String> setSessionData() async {
    String sessionId = const Uuid().v4();
    Map<String, dynamic> sessionData = {
      'tableId': _table.id,
      'sessionId': sessionId,
    };
    await _prefs.setPreference<String>('sessionData', jsonEncode(sessionData));
    _sessionId = sessionId;
    return sessionId;
  }

  Future<void> initialize() async {
    int? tableId = await _prefs.getPreference<int>('tableId');
    if (tableId != null) {
      await configureTable(tableId);
    } else {
      await _prefs.removePreference('sessionData');
      Get.offAll(
        () => ConfigureScreen(
          withPin: false,
        ),
      );
    }
  }

  updateWaitingStatus(bool waitingStatus) {
    _prefs.setPreference('waitingMode', waitingStatus);
  }
}
