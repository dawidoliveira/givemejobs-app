import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/settings/settings_store.dart';
import 'package:give_me_jobs_app/app/modules/settings/widgets/item_button/item_button_widget.dart';
import 'package:give_me_jobs_app/app/modules/settings/widgets/section/section_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/custom_drawer/custom_drawer.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({Key? key, this.title = 'Configurações'})
      : super(key: key);
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends ModularState<SettingsPage, SettingsStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SectionWidget(
              icon: Icons.person_outline_rounded,
              label: 'Perfil',
            ),
            ItemButtonWidget(
              label: 'Editar perfil',
              onTap: () {
                Navigator.of(context).pushNamed('./edit-profile');
              },
            ),
            const SectionWidget(
              icon: Icons.info_outline_rounded,
              label: 'Sobre',
            ),
            ItemButtonWidget(
              label: 'Quem somos nós',
              onTap: () {},
            ),
            ItemButtonWidget(
              label: 'Licença',
              onTap: () {},
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton.icon(
                onPressed: store.logout,
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                label: Text(
                  'Desconectar',
                  style: AppTextStyles.button.copyWith(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
