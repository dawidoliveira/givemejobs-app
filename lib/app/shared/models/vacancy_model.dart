import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_me_jobs_app/app/shared/models/course_model.dart';

class VacancyModel {
  final String? id;
  final CourseModel course;
  final String title;
  final String desc;
  final int qntVacancy;
  final String? doc;
  final DateTime createdAt;

  VacancyModel({
    this.id,
    required this.course,
    required this.title,
    required this.desc,
    required this.qntVacancy,
    required this.createdAt,
    this.doc,
  });

  VacancyModel copyWith({
    String? id,
    CourseModel? course,
    String? title,
    String? desc,
    int? qntVacancy,
    String? doc,
    DateTime? createdAt,
  }) {
    return VacancyModel(
      id: id ?? this.id,
      course: course ?? this.course,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      qntVacancy: qntVacancy ?? this.qntVacancy,
      doc: doc ?? this.doc,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course': course.toMap(),
      'title': title,
      'desc': desc,
      'qntVacancy': qntVacancy,
      'doc': doc,
      'createdAt': createdAt,
    };
  }

  factory VacancyModel.fromMap(Map<String, dynamic> map) {
    return VacancyModel(
      id: map['id'] as String,
      course: map['course'] as CourseModel,
      title: map['title'] as String,
      desc: map['desc'] as String,
      qntVacancy: map['qntVacancy'] as int,
      doc: map['doc'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory VacancyModel.fromJson(String source) =>
      VacancyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VacancyModel(id: $id, course: $course, title: $title, desc: $desc, qntVacancy: $qntVacancy, doc: $doc, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VacancyModel &&
        other.id == id &&
        other.course == course &&
        other.title == title &&
        other.desc == desc &&
        other.qntVacancy == qntVacancy &&
        other.createdAt == createdAt &&
        other.doc == doc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        course.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        qntVacancy.hashCode ^
        createdAt.hashCode ^
        doc.hashCode;
  }
}
