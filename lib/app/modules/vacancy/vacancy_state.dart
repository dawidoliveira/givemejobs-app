import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

class VacancyState {
  UserModel? user;
  VacancyState({
    this.user,
  });

  factory VacancyState.initialState() {
    return VacancyState();
  }

  VacancyState copyWith({
    UserModel? user,
  }) {
    return VacancyState(
      user: user ?? this.user,
    );
  }
}
