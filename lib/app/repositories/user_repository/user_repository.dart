import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository_interface.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

class UserRepository implements IUserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;
  final Connectivity _connectivity;
  final CourseRepository _courseRepository;
  UserModel? user;

  UserRepository(this._firestore, this._auth, this._storage, this._connectivity,
      this._courseRepository) {
    getUser();
  }

  @override
  Future<void> createUserWithEmailAndPassword({required UserModel user}) async {
    try {
      _auth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      )
          .then((value) async {
        var downloadImgUrl = "";
        if (user.imgUrl != null) {
          downloadImgUrl = await updateFile(
            pathRef: '/users/${value.user!.uid}/profile/${user.fullname}',
            pathFile: user.imgUrl!,
          );
        }
        var downloadFileUrl = "";
        if (user.curriculum != null) {
          downloadFileUrl = await updateFile(
            pathRef: '/users/${value.user!.uid}/docs/curriculum',
            pathFile: user.curriculum!,
          );
        }
        await _firestore.collection('users').doc(value.user!.uid).set({
          'name': user.fullname,
          'email': user.email,
          'course': user.course.id,
          'imgUrl': downloadImgUrl,
          'curriculum': downloadFileUrl,
          'registration': user.registration,
          'type': 1,
        });

        await LocalStorage.saveData(
          key: 'user',
          data: UserModel.fromMap({
            'id': value.user!.uid,
            'curriculum': downloadFileUrl,
            'imgUrl': downloadImgUrl,
            'email': user.email,
            'registration': user.registration,
            'fullname': user.fullname,
            'course': user.course,
          }).toJson(),
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateFile(
      {required String pathRef, required String pathFile}) async {
    if (!pathFile.contains('http')) {
      await _storage.ref(pathRef).putFile(File(pathFile));
    }
    return _storage.ref(pathRef).getDownloadURL();
  }

  @override
  Future<void> editUser({required UserModel user}) async {
    try {
      var downloadImgUrl = "";
      if (user.imgUrl != null) {
        downloadImgUrl = await updateFile(
          pathRef: '/users/${user.id}/profile/${user.id}',
          pathFile: user.imgUrl!,
        );
      }
      var downloadFileUrl = "";
      if (user.curriculum != null) {
        downloadFileUrl = await updateFile(
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

      await LocalStorage.saveData(
        key: 'user',
        data: UserModel.fromMap({
          'id': user.id,
          'curriculum': downloadFileUrl,
          'imgUrl': downloadImgUrl,
          'email': user.email,
          'registration': user.registration,
          'fullname': user.fullname,
          'course': user.course.toJson(),
        }).toJson(),
      );
      await getUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      user = UserModel.fromJson(await LocalStorage.getData(key: 'user'));
      if (await _connectivity.checkConnectivity() != ConnectivityResult.none) {
        await _firestore
            .collection('users')
            .doc(user!.id)
            .get()
            .then((value) async {
          user = UserModel.fromMap({
            'id': value.id,
            'registration': value.get('registration'),
            'fullname': value.get('name'),
            'course': (await _courseRepository.getAllCourses())
                .firstWhere(
                    (element) => element.id == value.get('course') as String)
                .toJson(),
            'curriculum': value.get('curriculum'),
            'email': value.get('email'),
            'imgUrl': value.get('imgUrl'),
          });
        });
      }
      return user!;
    } catch (e) {
      rethrow;
    }
  }
}
