import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/core/login_guard.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_module.dart';
import 'package:give_me_jobs_app/app/modules/login/login_module.dart';
import 'package:give_me_jobs_app/app/modules/settings/settings_module.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_module.dart';
import 'package:give_me_jobs_app/app/modules/splash/splash_module.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_app/app/repositories/vacancy_repository/vacancy_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind((i) => SharedPreferences.getInstance()),
    Bind.singleton(
        (i) => CourseRepository(FirebaseFirestore.instance, Connectivity())),
    Bind.lazySingleton(
        (i) => VacancyRepository(FirebaseFirestore.instance, i())),
    Bind.lazySingleton((i) => UserRepository(FirebaseFirestore.instance,
        FirebaseAuth.instance, FirebaseStorage.instance, Connectivity(), i())),
    Bind.lazySingleton((i) =>
        AuthService(FirebaseAuth.instance, FirebaseFirestore.instance, i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/home',
      module: HomeModule(),
    ),
    ModuleRoute(
      '/settings',
      module: SettingsModule(),
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
      guards: [
        LoginGuard(),
      ],
    ),
    ModuleRoute(
      '/forgot-password',
      module: ForgotPasswordModule(),
      transition: TransitionType.rightToLeft,
      guards: [
        LoginGuard(),
      ],
    ),
    ModuleRoute(
      '/signup',
      module: SignupModule(),
      transition: TransitionType.rightToLeft,
      guards: [
        LoginGuard(),
      ],
    ),
    ModuleRoute(
      Modular.initialRoute,
      module: SplashModule(),
    ),
  ];
}
