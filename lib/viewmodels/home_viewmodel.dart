import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/artikel.dart';
import '../services/artikel_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ArtikelService _artikelService = ArtikelService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int selectedIndex = 0;

  List<Artikel> artikelList = [];
  bool isLoading = false;

  File? profileImage;

  User? get user => _auth.currentUser;
  String get displayName =>
      user?.displayName?.isNotEmpty == true ? user!.displayName! : "User";

  HomeViewModel() {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await Future.wait([loadArtikel(), loadProfileImage()]);
  }

  Future<void> loadArtikel() async {
    try {
      isLoading = true;
      notifyListeners();

      artikelList = await _artikelService.fetchArtikel();
    } catch (e) {
      artikelList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image');

    if (path != null && File(path).existsSync()) {
      profileImage = File(path);
      notifyListeners();
    }
  }

  void changeTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
