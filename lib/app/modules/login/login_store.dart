import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/utils.dart';
import 'package:give_me_jobs_app/app/modules/login/login_state.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';

class LoginStore extends NotifierStore<Exception, LoginState> {
  final AuthService _authService;

  LoginStore(this._authService) : super(LoginState.initialState());

  Future<void> login(BuildContext context) async {
    setLoading(true);
    if (state.formKey!.currentState!.validate()) {
      await _authService
          .signInWithEmailAndPassword(
        email: state.email!.text.trim(),
        pass: state.pass!.text.trim(),
      )
          .then((value) async {
        await Modular.get<UserRepository>().getUser();
        Modular.to.pushReplacementNamed('/home');
      }).onError((error, stackTrace) {
        setError(Exception(error));
        Utils.feedBack(
          isSuccess: false,
          context: context,
          message:
              'Erro ao fazer login, seu email e/ou senha podem estar incorretos!',
        );
      }).whenComplete(() {
        setLoading(false);
      });
    }
    setLoading(false);
  }

  String? emailValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Email inválido';
    }
  }

  String? passValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Senha inválida';
    }
  }
}
