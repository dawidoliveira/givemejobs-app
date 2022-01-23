import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/my_vacancy/my_vacancy_page.dart';

class MyVacancyModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MyVacancyPage()),
  ];
}
