import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/shared/models/course_model.dart';

class CourseRepository {
  final FirebaseFirestore _firestore;
  final Connectivity _connectivity;
  List<CourseModel>? courses;
  final LocalStorage _localStorage;

  CourseRepository(this._firestore, this._connectivity, this._localStorage) {
    getAllCourses();
  }

  Future<List<CourseModel>> getAllCourses() async {
    try {
      final list = (await _localStorage.getListData(key: 'courses'))
              ?.map((e) => CourseModel.fromJson(e))
              .toList() ??
          <CourseModel>[];

      if (await _connectivity.checkConnectivity() != ConnectivityResult.none) {
        final response = await _firestore.collection("courses").get();
        list.clear();
        list.addAll(response.docs.map<CourseModel>((e) => CourseModel.fromMap({
              'id': e.id,
              'name': e.get('name'),
            })));
        await _localStorage.saveListData(
            key: 'courses', data: list.map((e) => e.toJson()).toList());
      }
      courses = list;
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
