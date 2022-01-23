import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_colors.dart';
import 'package:give_me_jobs_app/app/core/app_images.dart';
import 'package:give_me_jobs_app/app/modules/splash/splash_state.dart';
import 'package:give_me_jobs_app/app/modules/splash/splash_store.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends ModularState<SplashPage, SplashStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSplash,
      body: Center(
        child: TripleBuilder<SplashStore, Exception, SplashState>(
          store: store,
          builder: (_, triple) => AnimatedContainer(
            duration: Duration(seconds: triple.state.durationInSeconds!),
            curve: Curves.bounceOut,
            height: triple.state.height,
            child: Image.asset(
              AppImages.logo,
            ),
          ),
        ),
      ),
    );
  }
}
