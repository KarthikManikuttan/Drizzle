import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drizzle/models/signin_email_model.dart';
import 'package:drizzle/models/signup_email_model.dart';
import 'package:drizzle/viewModels/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  User? _getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  FirebaseFirestore get firestore => _firestore;

  User? get getCurrentUser => _getCurrentUser();

  Future loginWithEmail({required SigninEmailModel signInEmailModel}) async {
    isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: signInEmailModel.email, password: signInEmailModel.password);

      await FirestoreServices().updateFcm(userCredential);

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
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUpEmailModel.email,
        password: signUpEmailModel.password,
      );
      await FirestoreServices().addUserDetails(
        userCredential,
        signUpEmailModel.userName,
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

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      ));

      await FirestoreServices().addUserDetails(userCredential, getCurrentUser!.displayName!);
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

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirestoreServices().addUserDetails(userCredential, getCurrentUser!.displayName!);

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
