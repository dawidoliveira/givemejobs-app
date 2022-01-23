import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:give_me_jobs_app/app/modules/forgot_password/forgot_password_module.dart';

void main() {
  setUpAll(() {
    initModule(ForgotPasswordModule());
  });
}
