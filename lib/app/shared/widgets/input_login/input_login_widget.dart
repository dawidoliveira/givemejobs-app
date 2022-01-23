import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';

class InputLoginWidget extends StatefulWidget {
  const InputLoginWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.isPass,
    required this.textCapitalization,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPass;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const InputLoginWidget.email({
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.label = 'E-mail',
    this.hint = 'ufal@ufal.com',
    this.isPass = false,
    this.keyboardType = TextInputType.emailAddress,
    this.validator,
  });

  const InputLoginWidget.pass({
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.visiblePassword,
    this.label = 'Senha',
    this.hint = '******',
    this.isPass = true,
    this.validator,
  });

  @override
  _InputLoginWidgetState createState() => _InputLoginWidgetState();
}

class _InputLoginWidgetState extends State<InputLoginWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: widget.textCapitalization,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      style: AppTextStyles.input,
      validator: widget.validator,
      obscureText: widget.isPass && _obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: widget.hint,
        filled: true,
        suffixIcon: widget.isPass
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
