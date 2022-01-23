import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/modules/splash/splash_state.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';

class SplashStore extends NotifierStore<Exception, SplashState> {
  final AuthService _authService;
  SplashStore(this._authService) : super(SplashState.initialState()) {
    init();
  }

  Future<void> init() async {
    updateState(height: 0);

    await Future.delayed(
      Duration(seconds: state.durationInSeconds!),
    );
    updateState(height: 150);
    await Future.delayed(
      const Duration(seconds: 1),
    );
    await redirect();
  }

  Future<void> redirect() async {
    if (await _authService.checkLogin()) {
      Modular.to.pushReplacementNamed('/home');
    } else {
      Modular.to.pushReplacementNamed('/login');
    }
  }

  void updateState({double? height, int? durationInSeconds}) {
    final newState = state.copyWith(
      durationInSeconds: durationInSeconds,
      height: height,
    );

    update(newState);
  }
}
