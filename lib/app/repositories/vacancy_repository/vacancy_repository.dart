import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/local_storage/local_storage.dart';
import 'package:give_me_jobs_app/app/repositories/vacancy_repository/vacancy_repository_interface.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';

class VacancyRepository implements IVacancyRepository {
  final FirebaseFirestore _firestore;
  final CourseRepository _courseRepository;
  final LocalStorage _localStorage;

  VacancyRepository(
      this._firestore, this._courseRepository, this._localStorage);

  @override
  Future<List<VacancyModel>> getVacancies() async {
    try {
      final userDataLocalStorage = await _localStorage.getData(key: 'user');
      if (userDataLocalStorage == null) return [];
      final user = UserModel.fromJson(userDataLocalStorage);
      final course = (await _courseRepository.getAllCourses())
          .firstWhere((element) => element.id == user.course.id);
      final List<VacancyModel> list = [];

      for (final item in (await _firestore.collection('users').get()).docs) {
        if (item.get('type') == 2) {
          for (final vacancy in (await _firestore
                  .collection('vacancies')
                  .doc(user.course.id)
                  .collection(item.id)
                  .get())
              .docs) {
            list.add(VacancyModel.fromMap({
              'id': vacancy.id,
              'course': course,
              'title': vacancy.get('title'),
              'desc': vacancy.get('desc'),
              'qntVacancy': vacancy.get('qntVacancy'),
              'doc': vacancy.get('notice'),
              'createdAt': vacancy.get('createdAt'),
            }));
          }
        }
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future fillVacancy(
      {required UserModel user, required String vacancyId}) async {
    try {
      final userAux = await _firestore.collection('users').doc(user.id).get();
      for (final item in (await _firestore.collection('users').get()).docs) {
        if (item.get('type') == 2) {
          for (final vacancy in (await _firestore
                  .collection('vacancies')
                  .doc(user.course.id)
                  .collection(item.id)
                  .get())
              .docs) {
            if (vacancy.id == vacancyId) {
              await _firestore
                  .collection('vacancies')
                  .doc(user.course.id)
                  .collection(item.id)
                  .doc(vacancyId)
                  .collection('candidates')
                  .doc(user.id)
                  .set({
                'name': user.fullname,
                'email': user.email,
                'course': user.course.id,
                'imgUrl': userAux.get('imgUrl'),
                'curriculum': userAux.get('curriculum'),
                'registration': user.registration,
              });
            }
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VacancyModel>> getMyVacancies() async {
    try {
      final userDataLocalStorage = await _localStorage.getData(key: 'user');
      if (userDataLocalStorage == null) return [];
      final user = UserModel.fromJson(userDataLocalStorage);

      final list = <VacancyModel>[];

      for (final item in (await _firestore.collection('users').get()).docs) {
        if (item.get('type') == 2) {
          for (final vacancy in (await _firestore
                  .collection('vacancies')
                  .doc(user.course.id)
                  .collection(item.id)
                  .get())
              .docs) {
            for (final vac in (await _firestore
                    .collection('vacancies')
                    .doc(user.course.id)
                    .collection(item.id)
                    .doc(vacancy.id)
                    .collection('candidates')
                    .get())
                .docs) {
              if (vac.id == user.id) {
                list.add(VacancyModel.fromMap({
                  'id': vacancy.id,
                  'course': user.course,
                  'title': vacancy.get('title'),
                  'desc': vacancy.get('desc'),
                  'doc': vacancy.get('notice'),
                  'qntVacancy': vacancy.get('qntVacancy'),
                  'createdAt': vacancy.get('createdAt'),
                }));
              }
            }
          }
        }
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
