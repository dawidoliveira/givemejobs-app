import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/utils.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_state.dart';
import 'package:give_me_jobs_app/app/modules/home/home_store.dart';
import 'package:give_me_jobs_app/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_app/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_app/app/services/auth_service/auth_service.dart';
import 'package:give_me_jobs_app/app/shared/models/course_model.dart';
import 'package:give_me_jobs_app/app/shared/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileStore extends NotifierStore<Exception, EditProfileState> {
  final AuthService _authService;
  final UserRepository _userRepository;
  final CourseRepository _courseRepository;
  EditProfileStore(
      this._authService, this._courseRepository, this._userRepository)
      : super(EditProfileState.initialState()) {
    init();
  }

  UserModel get user => _authService.loggedUser!;

  Future<void> init() async {
    final newState = state.copyWith(
      user: user,
      courses: _courseRepository.courses,
      selectedCourse: user.course,
      curriculum: TextEditingController(
        text: user.curriculum ?? '',
      ),
      name: TextEditingController(
        text: user.fullname,
      ),
      registration: TextEditingController(
        text: user.registration,
      ),
    );
    update(newState);
  }

  Future<void> updateUser(BuildContext context) async {
    setLoading(true);
    final newState = state.copyWith(
      user: state.user!.copyWith(
        fullname: state.name!.text,
        course: state.selectedCourse,
        registration: state.registration!.text,
      ),
    );
    update(newState);

    try {
      final newUserData = await _userRepository.editUser(user: newState.user!);

      _authService.loggedUser = newUserData;

      Utils.feedBack(
          isSuccess: true, context: context, message: 'Alterado com sucesso!');

      Modular.get<HomeStore>().init();
    } catch (e) {
      setError(Exception(error));
      Utils.feedBack(
          isSuccess: false,
          context: context,
          message: 'Erro ao alterar seus dados!');
    } finally {
      setLoading(false);
    }
  }

  Future<void> changeCurriculum() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    final file = File(result.files.single.path!);

    final newState = state.copyWith(
      user: state.user!.copyWith(
        curriculum: file.path,
      ),
      curriculum: TextEditingController(
        text: file.path.split('/').last,
      ),
    );
    update(newState);
  }

  Future<void> changeImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final newState = state.copyWith(
      user: state.user!.copyWith(
        imgUrl: image.path,
      ),
    );
    update(newState);
  }

  void onChanged(CourseModel? value) {
    final newState = state.copyWith(
      selectedCourse: value,
    );

    update(newState);
  }
}
