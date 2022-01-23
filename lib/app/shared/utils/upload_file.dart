import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadFile {
  UploadFile._();

  static Future<String> updateFile(
      {required String pathRef, required String pathFile}) async {
    if (!pathFile.contains('http')) {
      await FirebaseStorage.instance.ref(pathRef).putFile(File(pathFile));
    }
    return FirebaseStorage.instance.ref(pathRef).getDownloadURL();
  }
}
