import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_images.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/core/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'UFAL - GiveMeJobs\nCampus Arapiraca',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    onTap: () {
                      if (!Utils.sameRoute(context, toRoute: "/home/")) {
                        Navigator.pushReplacementNamed(context, "/home/");
                      }
                    },
                    leading: const Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: AppTextStyles.tileTitle
                          .copyWith(color: Colors.grey[700]),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      if (!Utils.sameRoute(context, toRoute: "/settings/")) {
                        Navigator.pushNamed(context, "/settings/");
                      }
                    },
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'Configurações',
                      style: AppTextStyles.tileTitle
                          .copyWith(color: Colors.grey[700]),
                    ),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Text(
              'Feito por Dáwid Silva',
              textAlign: TextAlign.center,
              style: AppTextStyles.content.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
