import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_module.dart';

void main() {
  setUpAll(() {
    initModule(SignupModule());
  });
}
