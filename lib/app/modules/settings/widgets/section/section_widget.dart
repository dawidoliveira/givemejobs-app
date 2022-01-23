import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            label,
            style: AppTextStyles.tileTitle.copyWith(
              color: Colors.grey[700],
              fontSize: 18,
            ),
          ),
          minLeadingWidth: 5,
        ),
      ],
    );
  }
}
