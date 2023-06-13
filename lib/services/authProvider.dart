import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool obscureText = true; // Add obscureText property

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error Occurred'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error Occurred'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (e == 'email already have in used') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error Occurred'),
            content: Text('Email already in use'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
