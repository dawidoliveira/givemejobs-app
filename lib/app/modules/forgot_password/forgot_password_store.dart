import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/utils.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_state.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';

class ForgotPasswordStore
    extends NotifierStore<Exception, ForgotPasswordState> {
  final AuthService _authService;
  ForgotPasswordStore(this._authService)
      : super(ForgotPasswordState.initialState());

  Future<void> sendRecuperationPass(BuildContext context) async {
    setLoading(true);
    await _authService.sendResetPass(email: state.email!.text).then((value) {
      Utils.feedBack(
        context: context,
        isSuccess: true,
        message: 'Email enviado com sucesso, verifique sua caixa de entrada!',
      );
    }).onError((error, stackTrace) {
      Utils.feedBack(
        context: context,
        isSuccess: false,
        message:
            'Erro ao enviar o email, por favor, verifique sua conexão com a internet e se o email digitado está correto!',
      );
    });
    setLoading(false);
  }
}
