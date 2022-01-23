import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_module.dart';
import 'package:give_me_jobs_app/app/modules/home/home_module.dart';
import 'package:give_me_jobs_app/app/modules/login/login_module.dart';
import 'package:give_me_jobs_app/app/modules/settings/settings_module.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_module.dart';
import 'package:give_me_jobs_app/app/modules/splash/splash_module.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_app/app/repositories/vacancy_repository/vacancy_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FirebaseFirestore.instance),
    Bind.lazySingleton((i) => Connectivity()),
    Bind.lazySingleton((i) => FirebaseAuth.instance),
    Bind.lazySingleton((i) => FirebaseStorage.instance),
    Bind.lazySingleton((i) => LocalStorage()),
    Bind.lazySingleton((i) => CourseRepository(i(), i(), i())),
    Bind.lazySingleton((i) => VacancyRepository(i(), i(), i())),
    Bind.lazySingleton((i) => UserRepository(i(), i(), i(), i())),
    Bind.lazySingleton((i) => AuthService(i(), i(), i(), i(), i())),
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
    ),
    ModuleRoute(
      '/forgot-password',
      module: ForgotPasswordModule(),
      transition: TransitionType.rightToLeft,
    ),
    ModuleRoute(
      '/signup',
      module: SignupModule(),
      transition: TransitionType.rightToLeft,
    ),
    ModuleRoute(
      Modular.initialRoute,
      module: SplashModule(),
    ),
  ];
}
