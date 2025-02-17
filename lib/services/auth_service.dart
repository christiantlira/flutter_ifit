import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iFit/screens/login/loginTela.dart';

class AuthService {
  Future<void> SignUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.popAndPushNamed(context, "/login");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'A senha é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Já existe uma conta com esse email.';
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14);
    } catch (e) {}
  }

  Future<void> SignInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user?.displayName);
      await Future.delayed(Duration(seconds: 1));
      Navigator.popAndPushNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'account-exists-with-different-credential') {
        String? email = e.email;
        AuthCredential? pendingCredential = e.credential;
      }
    }
  }

  Future<void> SignOut({
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.popAndPushNamed(context, "/login");
  }

  Future<void> SignIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.popAndPushNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Nenhum usuário encontrado com esse email';
      } else if (e.code == 'wrong-password') {
        message = 'A senha está errada';
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14);
    }
  }
}
