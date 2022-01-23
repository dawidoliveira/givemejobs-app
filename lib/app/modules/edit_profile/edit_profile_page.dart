import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_state.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_store.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/input/input_widget.dart';

class EditProfilePage extends StatefulWidget {
  final String title;
  const EditProfilePage({Key? key, this.title = 'EditProfilePage'})
      : super(key: key);
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState
    extends ModularState<EditProfilePage, EditProfileStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          store: store,
        ),
        preferredSize: const Size.fromHeight(140),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: SingleChildScrollView(
          child: TripleBuilder<EditProfileStore, Exception, EditProfileState>(
            store: store,
            builder: (context, triple) => Form(
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: store.changeImage,
                    icon: const Icon(Icons.camera),
                    label: Text(
                      'Alterar imagem',
                      style: AppTextStyles.button,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputWidget(
                    label: 'Matrícula',
                    controller: triple.state.registration,
                    titleField: 'Matrícula',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputWidget(
                    label: 'Nome',
                    controller: triple.state.name,
                    titleField: 'Nome',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField(
                    value: store.state.selectedCourse,
                    onChanged: store.onChanged,
                    items: store.state.courses!
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(
                              e.name,
                              style: AppTextStyles.input
                                  .copyWith(color: Colors.black),
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      labelText: 'Curso',
                      hintText: 'Selecione um curso...',
                      labelStyle:
                          AppTextStyles.input.copyWith(color: Colors.grey[600]),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: AppTextStyles.input,
                    ),
                    style: AppTextStyles.input,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputWidget(
                    enabled: false,
                    onTap: store.changeCurriculum,
                    titleField: 'Currículo',
                    controller: triple.state.curriculum,
                    label: 'Currículo',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TripleBuilder<EditProfileStore, Exception, EditProfileState>(
          store: store,
          builder: (context, triple) {
            return ButtonWidget(
              onPressed: () async {
                await store.updateUser(context);
              },
              labelButton: 'Editar',
              isLoading: triple.isLoading,
              width: MediaQuery.of(context).size.width,
            );
          },
        ),
      ),
    );
  }
}
