import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

abstract class IAuthService {
  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String pass});

  Future<dynamic> sendResetPass({required String email});

  Future<void> logout();

  Future<void> createUserWithEmailAndPassword({required UserModel user});
}
