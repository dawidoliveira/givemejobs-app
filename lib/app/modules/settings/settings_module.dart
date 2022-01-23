import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_module.dart';
import 'package:give_me_jobs_app/app/modules/settings/settings_Page.dart';
import 'package:give_me_jobs_app/app/modules/settings/settings_store.dart';

class SettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SettingsStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SettingsPage()),
    ModuleRoute('/edit-profile', module: EditProfileModule()),
  ];
}
