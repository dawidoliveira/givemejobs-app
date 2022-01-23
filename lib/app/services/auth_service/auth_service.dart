import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service_interface.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CourseRepository _courseRepository;

  AuthService(this._auth, this._firestore, this._courseRepository);

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut().then((_) async {
        await LocalStorage.deleteData(key: 'user');
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future sendResetPass({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signInWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      final existsEmail = (await _firestore.collection('users').get())
          .docs
          .firstWhere((element) => element.get('email') == email);

      if (existsEmail.exists && existsEmail.get('type') == 1) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: pass)
            .then((data) async {
          await _firestore
              .collection('users')
              .doc(data.user!.uid)
              .get()
              .then((value) async {
            await LocalStorage.saveData(
              key: 'user',
              data: UserModel.fromMap({
                'email': email,
                'registration': value.get('registration') as String,
                'fullname': value.get('name') as String,
                'course': (await _courseRepository.getAllCourses())
                    .firstWhere((element) =>
                        element.id == value.get('course') as String)
                    .toJson(),
                'id': data.user!.uid,
                'curriculum': value.get('curriculum') as String,
                'imgUrl': value.get('imgUrl') as String,
              }).toJson(),
            );
          });
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
