import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/modules/home/home_state.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_app/app/repositories/vacancy_repository/vacancy_repository.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';

class HomeStore extends NotifierStore<Exception, HomeState> {
  final UserRepository _userRepository;
  final VacancyRepository _vacancyRepository;

  HomeStore(this._userRepository, this._vacancyRepository)
      : super(HomeState.initialState()) {
    init();
  }

  Future<void> init() async {
    var newState = state.copyWith(
      user: _userRepository.user,
    );
    update(newState);
    setLoading(true);
    newState = state.copyWith(
      vacancies: await _vacancyRepository.getVacancies(),
      myVacancies: await _vacancyRepository.getMyVacancies(),
    );

    setLoading(false);
    update(newState);
  }

  void seeVacancy({required VacancyModel vacancy}) {
    Modular.to.pushNamed(
      './vacancy',
      arguments: {
        'vacancy': vacancy,
        'user': state.user,
      },
    );
  }

  void seeMyVacancy({required VacancyModel vacancy}) {
    // Modular.to.pushNamed(
    //   './my-vacancy',
    //   arguments: vacancy,
    // );
  }
}
