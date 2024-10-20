import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController extends GetxController {
  static PreferencesController instance = Get.find();

  // Generic function to save data
  Future<void> setPreference<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception("Unsupported type");
    }
  }

  // Generic function to get data
  Future<T?> getPreference<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw Exception("Unsupported type");
    }
  }

  //Generic function to check if key exists
  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Generic function to remove data
  Future<void> removePreference(String key) async {
    bool contains = await containsKey(key);
    if(!contains){
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
