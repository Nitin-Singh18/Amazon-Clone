import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

//Function to pick product image
Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    final pickedImages = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (pickedImages != null) {
      for (var element in pickedImages.files) {
        images.add(File(element.path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
