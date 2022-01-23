import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/my_vacancy/my_vacancy_store.dart';

class MyVacancyPage extends StatefulWidget {
  final String title;
  const MyVacancyPage({Key? key, this.title = 'MyVacancyPage'})
      : super(key: key);
  @override
  MyVacancyPageState createState() => MyVacancyPageState();
}

class MyVacancyPageState extends State<MyVacancyPage> {
  final MyVacancyStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stepper(
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Row(
            children: <Widget>[
              Container(),
              Container(),
            ],
          );
        },
        currentStep: 3,
        physics: const BouncingScrollPhysics(),
        steps: [
          stepVacancy(
            label: 'Candidatura visualizada',
            currentIndex: 0,
            state: 0 < 3 ? StepState.complete : StepState.indexed,
          ),
          stepVacancy(
            label: 'Candidatura baixada',
            currentIndex: 1,
            state: 1 < 3 ? StepState.complete : StepState.indexed,
          ),
          stepVacancy(
            label: 'Entrevista',
            state: 2 < 3 ? StepState.complete : StepState.indexed,
            currentIndex: 2,
          ),
          stepVacancy(
            label: 'Encerrado o processo',
            state: 3 < 3 ? StepState.complete : StepState.indexed,
            currentIndex: 3,
          ),
        ],
      ),
    );
  }

  Step stepVacancy(
      {required String label,
      required int currentIndex,
      required StepState state}) {
    return Step(
      title: Text(
        label,
        style: AppTextStyles.tileTitle.copyWith(
          color: Colors.black,
        ),
      ),
      content: Container(),
      isActive: currentIndex < 3 && true,
      state: state,
    );
  }
}
