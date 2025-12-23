import 'package:flutter/material.dart';
import '../models/artikel.dart';
import '../services/artikel_service.dart';

class ArtikelViewModel extends ChangeNotifier {
  final ArtikelService _service = ArtikelService();

  List<Artikel> _artikel = [];
  List<Artikel> get artikel => _artikel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchArtikel() async {
    _isLoading = true;
    notifyListeners();

    _artikel = await _service.fetchArtikel();

    _isLoading = false;
    notifyListeners();
  }
}
