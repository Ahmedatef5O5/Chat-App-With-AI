import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(
    String userName,
    String email,
    String password,
  );
  // Future<bool> authenticateWithGoogle();
  // Future<bool> authenticateWithFacebook();
  User? getCurrentUser();
  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in or sign up
  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Auth login error: $e');
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
    String userName,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Auth register error: $e');
      return false;
    }
  }

  @override
  User? getCurrentUser() => _auth.currentUser;

  @override
  Future<void> logout() => _auth.signOut();
}
