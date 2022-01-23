import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> editUser({required UserModel user});
  Future<UserModel?> getUser();
}
