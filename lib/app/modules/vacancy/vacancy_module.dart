import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/vacancy/vacancy_Page.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';

class VacancyModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => VacancyPage(
              vacancy: args.data['vacancy'] as VacancyModel,
              user: args.data['user'] as UserModel,
            )),
  ];
}
