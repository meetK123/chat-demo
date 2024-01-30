import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar
    ..showSnackBar(SnackBar(
      content: Text(content),
    ));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;

  try {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickImage != null) {
      image = File(pickImage.path);
    }
  } catch (e) {
    if(context.mounted) {
      showSnackBar(context: context, content: e.toString());
    }
  }
  return image;
}
