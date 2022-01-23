import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';

abstract class IVacancyRepository {
  Future<List<VacancyModel>> getVacancies();
  Future<List<VacancyModel>> getMyVacancies();
  Future fillVacancy({required UserModel user, required String vacancyId});
}
