import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static Future<void> saveData(
      {required String key, required String data}) async {
    final ps = await getInstance();

    await ps.setString(key, data);
  }

  static Future<void> saveListData(
      {required String key, required List<String> data}) async {
    final ps = await getInstance();

    await ps.setStringList(key, data);
  }

  static Future<String> getData({required String key}) async {
    final ps = await getInstance();

    return ps.getString(key)!;
  }

  static Future<List<String>?> getListData({required String key}) async {
    final ps = await getInstance();

    return ps.getStringList(key);
  }

  static Future<void> deleteData({required String key}) async {
    final ps = await getInstance();

    await ps.remove(key);
  }

  static Future<SharedPreferences> getInstance() async {
    await Modular.isModuleReady<AppModule>();
    return Modular.get<SharedPreferences>();
  }
}
