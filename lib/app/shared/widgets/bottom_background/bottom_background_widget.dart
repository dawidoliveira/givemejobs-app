import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_images.dart';

class BottomBackgroundWidget extends StatelessWidget {
  const BottomBackgroundWidget({
    Key? key,
    required Size size,
    required this.onPressed,
    required this.label,
    required this.textButton,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final void Function()? onPressed;
  final String label;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size.height * .25,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AppImages.bottom,
            width: _size.width,
            fit: BoxFit.fill,
          ),
          Image.asset(
            AppImages.bottom1,
            width: _size.width,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 0,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(label),
                TextButton(
                  onPressed: onPressed,
                  child: Text(textButton),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
