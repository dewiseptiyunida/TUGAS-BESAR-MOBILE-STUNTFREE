import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePickProvider extends ChangeNotifier {
  File? pickedImageFile;

  ImagePickProvider() {
    loadImage();
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage == null) return;

    pickedImageFile = File(pickedImage.path);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', pickedImageFile!.path);

    notifyListeners();
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');

    if (imagePath != null) {
      pickedImageFile = File(imagePath);
      notifyListeners();
    }
  }
}
