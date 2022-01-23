import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_store.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/input_login/input_login_widget.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({
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
          "Registre-se",
          style: AppTextStyles.content.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          value: store.state.selectedCourse,
          onChanged: store.onChanged,
          items: store.state.courses!
              .map(
                (e) => DropdownMenuItem(
                  child: Text(
                    e.name,
                    style: AppTextStyles.input.copyWith(color: Colors.black),
                  ),
                  value: e,
                ),
              )
              .toList(),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            hintText: 'Selecione um curso...',
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            fillColor: Colors.grey[300],
            hintStyle: AppTextStyles.input,
          ),
          style: AppTextStyles.input,
        ),
        const SizedBox(
          height: 10,
        ),
        InputLoginWidget.pass(
          controller: store.state.pass!,
          validator: store.passValidator,
        ),
        const SizedBox(
          height: 10,
        ),
        InputLoginWidget.pass(
          controller: store.state.confirmPass!,
          label: 'Confirme sua senha',
          validator: store.passValidator,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWidget(
              width: MediaQuery.of(context).size.width * .33,
              onPressed: store.previousPage,
              labelButton: 'Voltar',
            ),
            ButtonWidget(
              width: MediaQuery.of(context).size.width * .33,
              onPressed: store.nextPage,
              labelButton: 'Próximo',
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
