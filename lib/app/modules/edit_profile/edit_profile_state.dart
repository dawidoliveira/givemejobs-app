import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/shared/models/course_model.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';

class EditProfileState {
  UserModel? user;
  CourseModel? selectedCourse;
  List<CourseModel>? courses;
  TextEditingController? name;
  TextEditingController? registration;
  TextEditingController? curriculum;
  String? fileLabel;

  EditProfileState({
    this.user,
    this.selectedCourse,
    this.courses,
    this.fileLabel,
    this.name,
    this.curriculum,
    this.registration,
  });

  factory EditProfileState.initialState() {
    return EditProfileState(
      courses: const [],
      fileLabel: '',
      name: TextEditingController(),
      registration: TextEditingController(),
      curriculum: TextEditingController(),
    );
  }

  EditProfileState copyWith({
    UserModel? user,
    String? fileLabel,
    CourseModel? selectedCourse,
    List<CourseModel>? courses,
    TextEditingController? name,
    TextEditingController? registration,
    TextEditingController? curriculum,
  }) {
    return EditProfileState(
      user: user ?? this.user,
      fileLabel: fileLabel ?? this.fileLabel,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      courses: courses ?? this.courses,
      name: name ?? this.name,
      registration: registration ?? this.registration,
      curriculum: curriculum ?? this.curriculum,
    );
  }
}
