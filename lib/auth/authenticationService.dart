import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({
    required String eEmail,
    required String ePassword,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: eEmail,
        password: ePassword,
      );
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
