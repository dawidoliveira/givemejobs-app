import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';

class SettingsStore extends NotifierStore<Exception, int> {
  final AuthService _authService;

  SettingsStore(this._authService) : super(0);

  Future<void> logout() async {
    await _authService
        .logout()
        .then((_) => Modular.to.pushReplacementNamed('/login'));
  }
}
