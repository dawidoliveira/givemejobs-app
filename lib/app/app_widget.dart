import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/core/app_themes.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final Future<FirebaseApp> _firebaseInitialize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialize,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Erro ao abrir o aplicativo, por favor, feche e abra novamente!'),
            );
          }
          return MaterialApp(
            title: 'GiveMeJobs',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeLight,
          ).modular();
        });
  }
}
