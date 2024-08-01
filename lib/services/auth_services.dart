import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> signup({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String confirmpassword,
  }) async {
    if (password != confirmpassword) {
      throw FirebaseAuthException(code: 'passwords-do-not-match', message: 'Passwords do not match.');
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FirebaseAuthException(code: 'weak-password', message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseAuthException(code: 'email-already-in-use', message: 'An account already exists with that email.');
      } else {
        throw e;
      }
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(code: 'user-not-found', message: 'No user found with this email.');
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(code: 'wrong-password', message: 'Invalid password. Try again.');
      } else {
        throw e;
      }
    }
  }
}
