import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/utils.dart';
import 'package:give_me_jobs_app/app/modules/signup/signup_state.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';
import 'package:give_me_jobs_app/app/shared/models/course_model.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class SignupStore extends NotifierStore<Exception, SignupState> {
  final CourseRepository _courseRepository;
  final AuthService _authService;

  SignupStore(this._courseRepository, this._authService)
      : super(SignupState.initialState()) {
    init();
  }

  Future<void> init() async {
    final newState = state.copyWith(
      courses: await _courseRepository.getAllCourses(),
    );
    update(newState);
  }

  void onChanged(CourseModel? course) {
    final newState = state.copyWith(
      selectedCourse: course,
    );
    update(newState);
  }

  Future<void> nextPage() async {
    await state.pageController!.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> previousPage() async {
    await state.pageController!.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> changeImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final newState = state.copyWith(
      selectedImage: File(image.path),
    );

    update(newState);
  }

  String? emailValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Email inválido';
    }
  }

  String? passValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Email inválido';
    }
  }

  String? regValidator(String? value) {
    if (value == null || value.length < 8) {
      return 'Matrícula inválida';
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.length < 3) {
      return 'Nome inválido';
    }
  }

  bool get firstStepSignUpVerification =>
      state.registration!.text.isEmpty ||
      state.email!.text.isEmpty ||
      state.fullname!.text.isEmpty;
  bool get secondStepSignUpVerification =>
      state.selectedCourse == null ||
      state.pass!.text.isEmpty ||
      state.confirmPass!.text.isEmpty;

  Future<void> signUp(BuildContext context) async {
    setLoading(true);
    if (firstStepSignUpVerification) {
      state.pageController!.jumpToPage(0);
      Utils.feedBack(
        isSuccess: false,
        context: context,
        message: 'Preencha todos os campos corretamente!',
      );
    } else if (secondStepSignUpVerification) {
      state.pageController!.jumpToPage(1);
      Utils.feedBack(
        isSuccess: false,
        context: context,
        message: 'Preencha todos os campos corretamente!',
      );
    } else {
      if (state.formKey!.currentState!.validate()) {
        await _authService
            .createUserWithEmailAndPassword(
          user: UserModel(
            email: state.email!.text.trim(),
            registration: state.registration!.text.trim(),
            fullname: state.fullname!.text,
            course: state.selectedCourse!,
            password: state.pass!.text.trim(),
            imgUrl: state.selectedImage?.path,
          ),
        )
            .then((_) {
          Utils.feedBack(
            isSuccess: true,
            context: context,
            message: 'Cadastrado com sucesso!',
          );
          Modular.to
            ..pop()
            ..pushReplacementNamed('/home');
        });
      }
    }
    setLoading(false);
  }
}
