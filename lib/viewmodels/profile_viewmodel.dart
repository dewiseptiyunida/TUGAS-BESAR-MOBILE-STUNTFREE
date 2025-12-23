import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  User? get user => _auth.currentUser;

  File? profileImage;
  bool isLoading = false;

  ProfileViewModel() {
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image');

    if (path != null && File(path).existsSync()) {
      profileImage = File(path);
      notifyListeners();
    }
  }

  Future<void> pickProfileImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
    );

    if (picked != null) {
      profileImage = File(picked.path);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', picked.path);

      notifyListeners();
    }
  }

  Future<String?> updateProfile({
    required String name,
    required String email,
  }) async {
    if (user == null) return "User tidak ditemukan";

    try {
      isLoading = true;
      notifyListeners();

      await user!.updateDisplayName(name.trim());

      if (email.trim().isNotEmpty && email != user!.email) {
        await user!.verifyBeforeUpdateEmail(email.trim());
      }

      await user!.reload();
      isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
}
