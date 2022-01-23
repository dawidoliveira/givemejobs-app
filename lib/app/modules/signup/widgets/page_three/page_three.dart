import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_store.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';

class PageThree extends StatelessWidget {
  const PageThree({
    Key? key,
    required this.store,
  }) : super(key: key);

  final SignupStore store;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Escolha uma foto de perfil:",
          style: AppTextStyles.content.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TripleBuilder(
                store: store,
                builder: (context, triple) => CircleAvatar(
                  radius: 50,
                  foregroundImage: store.state.selectedImage != null
                      ? FileImage(store.state.selectedImage!)
                      : null,
                  child: store.state.selectedImage == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),
              ),
              TextButton.icon(
                onPressed: store.changeImage,
                icon: const Icon(Icons.camera),
                label: const Text('Alterar imagem'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWidget(
              width: MediaQuery.of(context).size.width * .33,
              onPressed: store.previousPage,
              labelButton: 'Voltar',
            ),
            TripleBuilder(
              store: store,
              builder: (context, triple) => ButtonWidget(
                width: MediaQuery.of(context).size.width * .33,
                onPressed: () {
                  store.signUp(context);
                },
                labelButton: 'Cadastrar',
                isLoading: triple.isLoading,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
