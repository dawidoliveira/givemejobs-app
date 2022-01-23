import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouterGuard implements RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final ps = await SharedPreferences.getInstance();
    if (ps.getString("user") != null && ps.getString("user")!.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  String? get guardedRoute => '/login';
}
