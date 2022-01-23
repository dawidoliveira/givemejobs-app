import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_store.dart';
import 'package:give_me_jobs_app/app/shared/widgets/bottom_background/bottom_background_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/input_login/input_login_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/top_background/top_background_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String title;
  const ForgotPasswordPage({Key? key, this.title = 'ForgotPasswordPage'})
      : super(key: key);
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState
    extends ModularState<ForgotPasswordPage, ForgotPasswordStore> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: _size.height,
          width: _size.width,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  TopBackgroundWidget(size: _size),
                  const SafeArea(
                    child: BackButton(),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: _size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Digite seu email:",
                        style: AppTextStyles.content.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: store.state.formKey,
                        child: Column(
                          children: [
                            InputLoginWidget.email(
                              controller: store.state.email!,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TripleBuilder(
                                store: store,
                                builder: (_, triple) => ButtonWidget(
                                  labelButton: 'Enviar',
                                  width: _size.width * .33,
                                  onPressed: () {
                                    store.sendRecuperationPass(context);
                                  },
                                  isLoading: triple.isLoading,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomBackgroundWidget(
                size: _size,
                label: 'Já tem uma conta?',
                onPressed: () {
                  Navigator.pop(context);
                },
                textButton: 'Faça o login!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
