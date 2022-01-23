import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/app_module.dart';
import 'package:give_me_jobs_app/app/modules/splash/splash_state.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashStore extends NotifierStore<Exception, SplashState> {
  final UserRepository _userRepository;
  SplashStore(this._userRepository) : super(SplashState.initialState()) {
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
    await Modular.isModuleReady<AppModule>();
    if (Modular.get<SharedPreferences>().getString("user") == null ||
        Modular.get<SharedPreferences>().getString("user")!.isEmpty) {
      Modular.to.pushReplacementNamed('/login');
    } else {
      await _userRepository.getUser();
      await Modular.to.pushReplacementNamed('/home');
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
