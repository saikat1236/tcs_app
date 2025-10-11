import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcs_app_fixed/auth/screens/signup.dart';
import 'package:tcs_app_fixed/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcs_app_fixed/pages/mainHome.dart';
import 'error_handler.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign out
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle(BuildContext context, WidgetRef ref) async {
    try {
      print("Initiating Google Sign-In...");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER",
          message: "Google Sign-In cancelled by user",
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("Signed in with Google: ${userCredential.user?.uid}");

      // Check if user exists in Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        print("User does not exist in Firestore, redirecting to SignupPage...");
        // Redirect to SignupPage to collect additional user details
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderScope(
              child: SignupPage(userCredential: userCredential),
            ),
          ),
        );
        return userCredential;
      } else {
        print("User exists in Firestore, redirecting to MainHome...");
        // User exists, redirect to MainHome
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderScope(child: MainHome()),
          ),
        );
        return userCredential;
      }
    } catch (e) {
      print("Error during Google Sign-In: $e");
      ErrorHandler().errorDialog(context, e);
      return null;
    }
  }
}