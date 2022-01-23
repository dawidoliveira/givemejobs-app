import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository_interface.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/utils/upload_file.dart';

class UserRepository implements IUserRepository {
  final FirebaseFirestore _firestore;
  final Connectivity _connectivity;
  final CourseRepository _courseRepository;
  final LocalStorage _localStorage;

  UserRepository(this._firestore, this._connectivity, this._courseRepository,
      this._localStorage) {
    getUser();
  }

  @override
  Future<UserModel> editUser({required UserModel user}) async {
    try {
      var downloadImgUrl = "";
      if (user.imgUrl != null && user.imgUrl != "") {
        downloadImgUrl = await UploadFile.updateFile(
          pathRef: '/users/${user.id}/profile/avatar',
          pathFile: user.imgUrl!,
        );
      }

      var downloadFileUrl = "";
      if (user.curriculum != null && user.curriculum != "") {
        downloadFileUrl = await UploadFile.updateFile(
          pathRef: '/users/${user.id}/docs/curriculum',
          pathFile: user.curriculum!,
        );
      }

      await _firestore.collection('users').doc(user.id).update({
        'name': user.fullname,
        'email': user.email,
        'course': user.course.id,
        'imgUrl': downloadImgUrl,
        'curriculum': downloadFileUrl,
        'registration': user.registration,
      });

      final newUserData = UserModel.fromMap({
        'id': user.id,
        'curriculum': downloadFileUrl,
        'imgUrl': downloadImgUrl,
        'email': user.email,
        'registration': user.registration,
        'fullname': user.fullname,
        'course': user.course.toJson(),
      });

      await _localStorage.saveData(
        key: 'user',
        data: newUserData.toJson(),
      );

      return newUserData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userDataLocalStorage = await _localStorage.getData(key: 'user');
      if (userDataLocalStorage == null) return null;
      final user = UserModel.fromJson(userDataLocalStorage);

      if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
        return user;
      }

      final userDataFromFirebase =
          await _firestore.collection('users').doc(user.id).get();

      final courses = await _courseRepository.getAllCourses();

      return UserModel.fromMap({
        'id': userDataFromFirebase.id,
        'registration': userDataFromFirebase.get('registration'),
        'fullname': userDataFromFirebase.get('name'),
        'course': courses
            .firstWhere((element) =>
                element.id == userDataFromFirebase.get('course') as String)
            .toJson(),
        'curriculum': userDataFromFirebase.get('curriculum'),
        'email': userDataFromFirebase.get('email'),
        'imgUrl': userDataFromFirebase.get('imgUrl'),
      });
    } catch (e) {
      rethrow;
    }
  }
}
