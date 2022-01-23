import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.labelButton,
    required this.width,
    this.isLoading = false,
  }) : super(key: key);

  final void Function()? onPressed;
  final bool isLoading;
  final String labelButton;
  final double width;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: widget.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          primary: Theme.of(context).primaryColor,
        ),
        onPressed: widget.onPressed,
        child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              )
            : Text(
                widget.labelButton,
                style: AppTextStyles.button,
              ),
      ),
    );
  }
}
