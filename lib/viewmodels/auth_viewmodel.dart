import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _fireAuth = FirebaseAuth.instance;

class AppAuthProvider extends ChangeNotifier {
  final form = GlobalKey<FormState>();

  var islogin = true;

  void submit({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (islogin) {
        await _fireAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final cred = await _fireAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await cred.user?.updateDisplayName(name);
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
