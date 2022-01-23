import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_page.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_store.dart';

class ForgotPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ForgotPasswordStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ForgotPasswordPage()),
  ];
}
