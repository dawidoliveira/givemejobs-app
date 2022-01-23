import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    required this.label,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.titleField,
  }) : super(key: key);

  final String label;
  final String? titleField;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? enabled;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: AppTextStyles.input,
        enabled: enabled,
        decoration: InputDecoration(
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
          hintText: label,
          labelStyle: AppTextStyles.input.copyWith(color: Colors.grey[600]),
          labelText: titleField,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
