import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';

class ItemButtonWidget extends StatelessWidget {
  const ItemButtonWidget({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: AppTextStyles.tileTitle.copyWith(
          color: Colors.grey[600],
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
