import 'package:drizzle/models/signin_email_model.dart';
import 'package:drizzle/models/signup_email_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;

  User? get user => _firebaseAuth.currentUser;

  Future loginWithEmail({required SigninEmailModel signInEmailModel}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: signInEmailModel.email, password: signInEmailModel.password);
      isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return e.message;
    }
  }

  Future signUpWithEmail({required SignupEmailModel signUpEmailModel}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUpEmailModel.email,
        password: signUpEmailModel.password,
      );
      isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signInWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();

      if (isLogged) GoogleSignIn().signOut();

      final result = await GoogleSignIn().signIn();

      if (result == null) return "Ocurred an error !";

      final GoogleSignInAuthentication gAuth = await result.authentication;

      await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      ));
      isLoading = false;
      notifyListeners();

      return null;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return e.message;
    }
  }

  Future signInWithFacebook() async {
    try {
      isLoading = true;
      notifyListeners();
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential('${loginResult.accessToken?.tokenString}');

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return e.message;
    }
  }
}
