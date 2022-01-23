import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service_interface.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/utils/upload_file.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CourseRepository _courseRepository;
  final LocalStorage _localStorage;
  final UserRepository _userRepository;

  final _loggedUser = ValueNotifier<UserModel?>(null);
  UserModel? get loggedUser => _loggedUser.value;
  set loggedUser(UserModel? value) => _loggedUser.value = value;

  AuthService(this._auth, this._firestore, this._courseRepository,
      this._localStorage, this._userRepository);

  Future<bool> checkLogin() async {
    final user = await _userRepository.getUser();

    if (user == null) return false;

    loggedUser = user;
    return true;
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut().then((_) async {
        await _localStorage.deleteData(key: 'user');
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

      if (existsEmail.exists && existsEmail.get('type') != 1) {
        throw Exception();
      }

      final userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      final user = userCredential.user!;

      final userDataFromFirebase =
          await _firestore.collection('users').doc(user.uid).get();

      loggedUser = UserModel.fromMap({
        'email': email,
        'registration': userDataFromFirebase.get('registration') as String,
        'fullname': userDataFromFirebase.get('name') as String,
        'course': (await _courseRepository.getAllCourses())
            .firstWhere((element) =>
                element.id == userDataFromFirebase.get('course') as String)
            .toJson(),
        'id': user.uid,
        'curriculum': userDataFromFirebase.get('curriculum') as String,
        'imgUrl': userDataFromFirebase.get('imgUrl') as String,
      });

      await _localStorage.saveData(key: 'user', data: loggedUser!.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword({required UserModel user}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      final createdUser = userCredential.user!;

      String downloadImgUrl = "";
      if (user.imgUrl != null) {
        downloadImgUrl = await UploadFile.updateFile(
          pathRef: '/users/${createdUser.uid}/profile/${user.fullname}',
          pathFile: user.imgUrl!,
        );
      }

      String downloadFileUrl = "";
      if (user.curriculum != null) {
        downloadFileUrl = await UploadFile.updateFile(
          pathRef: '/users/${createdUser.uid}/docs/curriculum',
          pathFile: user.curriculum!,
        );
      }

      await _firestore.collection('users').doc(createdUser.uid).set({
        'name': user.fullname,
        'email': user.email,
        'course': user.course.id,
        'imgUrl': downloadImgUrl,
        'curriculum': downloadFileUrl,
        'registration': user.registration,
        'type': 1,
      });

      loggedUser = UserModel.fromMap({
        'id': createdUser.uid,
        'curriculum': downloadFileUrl,
        'imgUrl': downloadImgUrl,
        'email': user.email,
        'registration': user.registration,
        'fullname': user.fullname,
        'course': user.course,
      });

      await _localStorage.saveData(
        key: 'user',
        data: loggedUser!.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
