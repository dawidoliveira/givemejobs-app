import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveData({required String key, required String data}) async {
    final ps = await SharedPreferences.getInstance();
    await ps.setString(key, data);
  }

  Future<void> saveListData(
      {required String key, required List<String> data}) async {
    final ps = await SharedPreferences.getInstance();
    await ps.setStringList(key, data);
  }

  Future<String?> getData({required String key}) async {
    final ps = await SharedPreferences.getInstance();
    return ps.getString(key);
  }

  Future<List<String>?> getListData({required String key}) async {
    final ps = await SharedPreferences.getInstance();
    return ps.getStringList(key);
  }

  Future<void> deleteData({required String key}) async {
    final ps = await SharedPreferences.getInstance();
    await ps.remove(key);
  }
}
