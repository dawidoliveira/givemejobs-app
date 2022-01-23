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
import 'package:give_me_jobs_app/app/shared/models/course_model.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileStore extends NotifierStore<Exception, EditProfileState> {
  final UserRepository _userRepository;
  final CourseRepository _courseRepository;
  EditProfileStore(this._userRepository, this._courseRepository)
      : super(EditProfileState.initialState()) {
    init();
  }

  Future<void> init() async {
    final newState = state.copyWith(
      user: _userRepository.user,
      courses: _courseRepository.courses,
      selectedCourse: _userRepository.user!.course,
      curriculum: TextEditingController(
        text: _userRepository.user!.curriculum ?? '',
      ),
      name: TextEditingController(
        text: _userRepository.user!.fullname,
      ),
      registration: TextEditingController(
        text: _userRepository.user!.registration,
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
    await _userRepository
        .editUser(
      user: newState.user!,
    )
        .then((_) async {
      await Modular.get<HomeStore>().init();
      Utils.feedBack(
          isSuccess: true, context: context, message: 'Alterado com sucesso!');
    }).onError((error, stackTrace) {
      setError(Exception(error));
      Utils.feedBack(
          isSuccess: false,
          context: context,
          message: 'Erro ao alterar seus dados!');
    });
    setLoading(false);
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
