import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/vacancy/vacancy_state.dart';
import 'package:give_me_jobs_app/app/modules/vacancy/vacancy_store.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';
import 'package:give_me_jobs_app/app/shared/widgets/button/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class VacancyPage extends StatefulWidget {
  final VacancyModel vacancy;
  final UserModel user;
  const VacancyPage({
    Key? key,
    required this.vacancy,
    required this.user,
  }) : super(key: key);
  @override
  VacancyPageState createState() => VacancyPageState();
}

class VacancyPageState extends ModularState<VacancyPage, VacancyStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vacancy.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: 'Descrição',
                  style: AppTextStyles.title,
                  children: [
                    TextSpan(
                      text: ':\n\n${widget.vacancy.desc}',
                      style: AppTextStyles.content.copyWith(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(
                  text: 'Quantidade de vagas',
                  style: AppTextStyles.title,
                  children: [
                    TextSpan(
                      text: ': ${widget.vacancy.qntVacancy}',
                      style: AppTextStyles.content.copyWith(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (widget.vacancy.doc != null && widget.vacancy.doc!.isNotEmpty)
                Text(
                  'Documentos:\n',
                  style: AppTextStyles.title,
                ),
              if (widget.vacancy.doc != null && widget.vacancy.doc!.isNotEmpty)
                ListTile(
                  onTap: () async => await canLaunch(widget.vacancy.doc!)
                      ? await launch(widget.vacancy.doc!)
                      : throw 'Erro ao abrir o documento',
                  title: Text(
                    'Edital',
                    style:
                        AppTextStyles.tileTitle.copyWith(color: Colors.black),
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TripleBuilder<VacancyStore, Exception, VacancyState>(
          store: store,
          builder: (context, triple) => ButtonWidget(
            onPressed: () async {
              await store.applyVacancy(
                  user: widget.user,
                  vacancyId: widget.vacancy.id!,
                  context: context);
            },
            labelButton: 'Quero me candidatar',
            isLoading: triple.isLoading,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
