import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/modules/home/home_state.dart';
import 'package:give_me_jobs_app/app/repositories/vacancy_repository/vacancy_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';

class HomeStore extends NotifierStore<Exception, HomeState> {
  final AuthService _authService;
  final VacancyRepository _vacancyRepository;

  HomeStore(this._authService, this._vacancyRepository)
      : super(HomeState.initialState()) {
    init();
  }

  UserModel get user => _authService.loggedUser!;

  Future<void> init() async {
    setLoading(true);
    final newState = state.copyWith(
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
        'user': user,
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
