import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_store.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/input_login/input_login_widget.dart';

class PageOne extends StatelessWidget {
  const PageOne({
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
        InputLoginWidget(
          controller: store.state.registration!,
          label: 'Matrícula',
          hint: 'xxxxxxxx',
          isPass: false,
          validator: store.regValidator,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.none,
        ),
        const SizedBox(
          height: 10,
        ),
        InputLoginWidget(
          controller: store.state.fullname!,
          label: 'Nome completo',
          hint: 'Dawid Silva',
          isPass: false,
          validator: store.nameValidator,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(
          height: 10,
        ),
        InputLoginWidget.email(
          controller: store.state.email!,
          validator: store.emailValidator,
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ButtonWidget(
            onPressed: store.nextPage,
            width: MediaQuery.of(context).size.width * .33,
            labelButton: 'Próximo',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
