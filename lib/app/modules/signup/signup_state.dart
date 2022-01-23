import 'dart:io';

import 'package:flutter/material.dart';

import 'package:give_me_jobs_app/app/shared/models/course_model.dart';

class SignupState {
  TextEditingController? email;
  TextEditingController? pass;
  TextEditingController? confirmPass;
  TextEditingController? registration;
  TextEditingController? fullname;
  GlobalKey<FormState>? formKey;
  PageController? pageController;
  List<CourseModel>? courses;
  CourseModel? selectedCourse;
  File? selectedImage;

  SignupState({
    this.email,
    this.pass,
    this.formKey,
    this.fullname,
    this.registration,
    this.courses,
    this.selectedCourse,
    this.pageController,
    this.confirmPass,
    this.selectedImage,
  });

  factory SignupState.initialState() {
    return SignupState(
      email: TextEditingController(),
      pass: TextEditingController(),
      formKey: GlobalKey<FormState>(),
      pageController: PageController(),
      fullname: TextEditingController(),
      registration: TextEditingController(),
      confirmPass: TextEditingController(),
      courses: [],
    );
  }

  SignupState copyWith({
    TextEditingController? email,
    TextEditingController? pass,
    TextEditingController? confirmPass,
    TextEditingController? registration,
    TextEditingController? fullname,
    PageController? pageController,
    GlobalKey<FormState>? formKey,
    List<CourseModel>? courses,
    CourseModel? selectedCourse,
    File? selectedImage,
  }) {
    return SignupState(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      selectedImage: selectedImage ?? this.selectedImage,
      confirmPass: confirmPass ?? this.confirmPass,
      pageController: pageController ?? this.pageController,
      registration: registration ?? this.registration,
      fullname: fullname ?? this.fullname,
      formKey: formKey ?? this.formKey,
      courses: courses ?? this.courses,
      selectedCourse: selectedCourse ?? this.selectedCourse,
    );
  }
}
