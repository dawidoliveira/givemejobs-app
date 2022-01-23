import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_page.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_store.dart';

class SignupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignupStore(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SignupPage()),
  ];
}
