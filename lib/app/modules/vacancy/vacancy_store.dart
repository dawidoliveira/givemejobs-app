import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/utils.dart';
import 'package:give_me_jobs_app/app/modules/home/home_store.dart';
import 'package:give_me_jobs_app/app/modules/vacancy/vacancy_state.dart';
import 'package:give_me_jobs_app/app/repositories/vacancy_repository/vacancy_repository.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

class VacancyStore extends NotifierStore<Exception, VacancyState> {
  final VacancyRepository _vacancyRepository;
  VacancyStore(this._vacancyRepository) : super(VacancyState.initialState());

  Future<void> applyVacancy(
      {required UserModel user,
      required String vacancyId,
      required BuildContext context}) async {
    setLoading(true);
    await _vacancyRepository
        .fillVacancy(
      user: user,
      vacancyId: vacancyId,
    )
        .then((value) async {
      await Modular.get<HomeStore>().init();
      Utils.feedBack(
          isSuccess: true,
          context: context,
          message: 'Você conseguiu se candidatar, agora é só aguardar!');
    });
    setLoading(false);
  }
}
