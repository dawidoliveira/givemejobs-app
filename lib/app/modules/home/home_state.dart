import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';

class HomeState {
  UserModel? user;
  List<VacancyModel>? vacancies;
  List<VacancyModel>? myVacancies;

  HomeState({
    this.user,
    this.vacancies,
    this.myVacancies,
  });

  factory HomeState.initialState() {
    return HomeState(
      vacancies: const [],
      myVacancies: const [],
    );
  }

  HomeState copyWith({
    UserModel? user,
    List<VacancyModel>? vacancies,
    List<VacancyModel>? myVacancies,
  }) {
    return HomeState(
      user: user ?? this.user,
      vacancies: vacancies ?? this.vacancies,
      myVacancies: myVacancies ?? this.myVacancies,
    );
  }
}
