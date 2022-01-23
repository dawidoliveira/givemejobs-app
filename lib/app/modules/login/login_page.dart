import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/login/login_store.dart';
import 'package:give_me_jobs_app/app/shared/widgets/bottom_background/bottom_background_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/input_login/input_login_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/top_background/top_background_widget.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginStore> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: _size.height,
          width: _size.width,
          child: Stack(
            children: <Widget>[
              TopBackgroundWidget(size: _size),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: _size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bem-vindo!\nFaça login.",
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
                            validator: store.emailValidator,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputLoginWidget.pass(
                            controller: store.state.pass!,
                            validator: store.passValidator,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.zero,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/forgot-password');
                              },
                              child: const Text('Esqueceu sua senha?'),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TripleBuilder(
                              store: store,
                              builder: (context, triple) => ButtonWidget(
                                width: _size.width * .33,
                                onPressed: () {
                                  store.login(context);
                                },
                                isLoading: triple.isLoading,
                                labelButton: 'Login',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: BottomBackgroundWidget(
                  size: _size,
                  label: 'Não tem uma conta?',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  textButton: 'Cadastre-se!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
