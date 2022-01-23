import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_store.dart';
import 'package:give_me_jobs_app/app/modules/signup/widgets/page_one/page_one.dart';
import 'package:give_me_jobs_app/app/modules/signup/widgets/page_three/page_three.dart';
import 'package:give_me_jobs_app/app/modules/signup/widgets/page_two/page_two.dart';
import 'package:give_me_jobs_app/app/shared/widgets/bottom_background/bottom_background_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/top_background/top_background_widget.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key? key, this.title = 'SignupPage'}) : super(key: key);
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends ModularState<SignupPage, SignupStore> {
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
                  child: Form(
                    key: store.state.formKey,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: store.state.pageController,
                      children: [
                        PageOne(
                          store: store,
                        ),
                        PageTwo(
                          store: store,
                        ),
                        PageThree(
                          store: store,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomBackgroundWidget(
                size: _size,
                label: 'Já tem uma conta?',
                onPressed: () {
                  Navigator.pop(context);
                },
                textButton: 'Faça login!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
