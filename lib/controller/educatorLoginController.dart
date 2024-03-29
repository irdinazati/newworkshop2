import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/educatorModel.dart';
import '../screen/mainFeedPage.dart';


class EducatorLoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> login(
      BuildContext context, EducatorModel educator) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: educator.email,
        password: educator.password,
      );
      if (userCredential.user != null) {
        String currentUserId = userCredential.user!.uid; // Assuming uid is the user ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainFeedPage(currentUserId: currentUserId),
          ),
        );
      }
      return userCredential;
    } on FirebaseAuthException catch (ex) {
      _showLoginFailedDialog(context);
      print('FirebaseAuthException: ${ex.message}');
      return null;
    }
  }

  void _showLoginFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid username or password.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}