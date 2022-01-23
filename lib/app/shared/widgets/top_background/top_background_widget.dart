import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_images.dart';

class TopBackgroundWidget extends StatelessWidget {
  const TopBackgroundWidget({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size.height * .30,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.asset(
            AppImages.top1,
            fit: BoxFit.fill,
            width: _size.width,
            height: _size.height * .25,
          ),
          Image.asset(
            AppImages.top,
            fit: BoxFit.fill,
            width: _size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SafeArea(
              child: Image.asset(
                AppImages.logo,
                height: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
