import 'dart:convert';

import 'package:give_me_jobs_app/app/shared/models/course_model.dart';

class UserModel {
  final String? id;
  final String registration;
  final String email;
  final String fullname;
  final String? password;
  final CourseModel course;
  final String? curriculum;
  final String? imgUrl;
  UserModel({
    this.id,
    required this.email,
    required this.registration,
    required this.fullname,
    this.password,
    required this.course,
    this.curriculum,
    this.imgUrl,
  });

  UserModel copyWith({
    String? id,
    String? registration,
    String? fullname,
    String? email,
    String? password,
    CourseModel? course,
    String? curriculum,
    String? imgUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      registration: registration ?? this.registration,
      fullname: fullname ?? this.fullname,
      password: password ?? this.password,
      course: course ?? this.course,
      curriculum: curriculum ?? this.curriculum,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'registration': registration,
      'fullname': fullname,
      'password': password,
      'course': course,
      'curriculum': curriculum,
      'email': email,
      'imgUrl': imgUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String?,
      email: map['email'] as String,
      registration: map['registration'] as String,
      fullname: map['fullname'] as String,
      password: map['password'] as String?,
      course: CourseModel.fromJson(map['course'] as String),
      curriculum: map['curriculum'] as String?,
      imgUrl: map['imgUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, registration: $registration, fullname: $fullname, password: $password, course: $course, curriculum: $curriculum, imgUrl: $imgUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.registration == registration &&
        other.fullname == fullname &&
        other.email == email &&
        other.password == password &&
        other.course == course &&
        other.curriculum == curriculum &&
        other.imgUrl == imgUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        registration.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        course.hashCode ^
        curriculum.hashCode ^
        imgUrl.hashCode;
  }
}
