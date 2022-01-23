import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';
import 'package:intl/intl.dart';

class ItemVacancyWidget extends StatelessWidget {
  const ItemVacancyWidget({
    Key? key,
    required this.onTap,
    required this.vacancy,
  }) : super(key: key);

  final void Function()? onTap;
  final VacancyModel vacancy;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: SizedBox(
        height: 20,
        child: Text(
          vacancy.title,
          style: AppTextStyles.tileTitle.copyWith(color: Colors.black),
        ),
      ),
      subtitle: SizedBox(
        height: 20,
        child: Text(
          vacancy.desc,
          style: AppTextStyles.subtitle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Container(
        height: 35,
        width: 38,
        alignment: Alignment.topRight,
        child: Text(
          '${DateFormat('HH:mm').format(vacancy.createdAt)}\n${DateFormat('dd/MM').format(vacancy.createdAt)}',
          style: AppTextStyles.subtitle.copyWith(fontSize: 12),
          textAlign: TextAlign.end,
        ),
      ),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(),
      ),
    );
  }
}
