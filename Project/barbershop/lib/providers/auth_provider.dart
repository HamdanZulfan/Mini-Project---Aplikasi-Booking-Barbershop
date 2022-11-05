import 'package:barbershop/screen/auth/widgets/snackbar.dart';
import 'package:barbershop/screen/home/navbar_screen.dart';
import 'package:barbershop/screen/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> streamAuthStatus() {
    return auth.authStateChanges();
  }

  void signUp(String email, String password, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      showTextMessage(context, 'Akun berhasil dibuat');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showTextMessage(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showTextMessage(context, 'The account already exists for that email.');
      }
    } catch (e) {
      return;
    }
  }

  void login(String email, String password, context) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const NavbarScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showTextMessage(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showTextMessage(context, 'Wrong password provided for that user');
      }
    }
  }

  void logOut(context) async {
    await auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<User?> getEmail() async {
    var namaEmail = auth.currentUser;
    return namaEmail;
  }
}
