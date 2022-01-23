import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_page.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_store.dart';

class EditProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EditProfileStore(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const EditProfilePage()),
  ];
}
