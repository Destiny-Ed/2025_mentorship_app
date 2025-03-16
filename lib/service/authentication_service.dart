import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_first_app/models/authentication_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  //login with email and password
  Future<AuthenticationModel> signUpWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return AuthenticationModel(message: "Account created successfully", status: true);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return AuthenticationModel(message: e.message ?? "error occured", status: false);
    } catch (e) {
      log(e.toString());
      return AuthenticationModel(message: "An error occured. please try again.", status: false);
    }
  }

  //sign up with email and password
  Future<AuthenticationModel> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return AuthenticationModel(message: "sign in was successful", status: true);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return AuthenticationModel(message: e.message ?? "error occured", status: false);
    } catch (e) {
      log(e.toString());
      return AuthenticationModel(message: "An error occured. please try again.", status: false);
    }
  }

  //logout user
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //google authentication
  Future<AuthenticationModel> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      return AuthenticationModel(
        message: "Sign in with Google was successful",
        status: true,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return AuthenticationModel(message: e.message ?? "error occured", status: false);
    } catch (e) {
      log(e.toString());
      return AuthenticationModel(
        message: "An error occured. please try again.",
        status: false,
      );
    }
  }
}
