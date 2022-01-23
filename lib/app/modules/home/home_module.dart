import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/my_vacancy/my_vacancy_page.dart';
import 'package:give_me_jobs_app/app/modules/my_vacancy/my_vacancy_store.dart';
import 'package:give_me_jobs_app/app/modules/vacancy/vacancy_page.dart';
import 'package:give_me_jobs_app/app/modules/vacancy/vacancy_store.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore(i(), i())),
    Bind.lazySingleton((i) => VacancyStore(i())),
    Bind.lazySingleton((i) => MyVacancyStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute(
      '/vacancy',
      child: (_, args) => VacancyPage(
        vacancy: args.data['vacancy'] as VacancyModel,
        user: args.data['user'] as UserModel,
      ),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute(
      '/my-vacancy',
      child: (_, args) => const MyVacancyPage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
  ];
}
