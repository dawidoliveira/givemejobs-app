import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_app/app/core/app_themes.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiveMeJobs',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeLight,
    ).modular();
  }
}
