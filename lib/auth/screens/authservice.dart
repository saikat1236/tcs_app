import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcs_app_fixed/auth/screens/signup.dart';
import 'package:tcs_app_fixed/models/user_model.dart';
// import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'error_handler.dart';
// import 'login_page.dart';

class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Determine if the user is authenticated.
  // handleAuth(BuildContext context) {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return const ExplorePage();
  //         } else {
  //           return const LoginPage();
  //         }
  //       });
  //   // return Routemaster.of(context).push('/signIn/');
  // }

  //Sign out
  signOut() {
    
    FirebaseAuth.instance.signOut();
  }

  //Sign In
  Future<UserCredential> signIn(String email, String password, context) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
      return val;
      // print('signed in');
    }).catchError((e) {
      ErrorHandler().errorDialog(context, e);
      return e;
    });
  }
  // prev Google Sign-In
  // Future<UserCredential> signInWithGoogle(BuildContext context) async {
  //   try {
  //     print("sign in with google");
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) throw FirebaseAuthException(code: "ERROR_ABORTED_BY_USER", message: "Login cancelled");

  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     return await _auth.signInWithCredential(credential);
  //   } catch (e) {
  //     ErrorHandler().errorDialog(context, e);
  //     rethrow;
  //   }
  // }

  // Google Sign-In
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      print("sign in with google");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(code: "ERROR_ABORTED_BY_USER", message: "Login cancelled");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Check if user exists in Firestore
      final userDoc = await _firestore
          .collection('users') // Adjust to your collection name
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        // User does not exist, redirect to SignupPage
        if (Navigator.canPop(context)) {
          Navigator.pop(context); // Close the Google Sign-In dialog if open
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderScope(
              child: SignupPage(),
            ),
          ),
        );
        return Future.error('User not found, redirected to signup'); // Indicate redirection
      }

      return userCredential; // User exists, return the credential
    } catch (e) {
      ErrorHandler().errorDialog(context, e);
      rethrow;
    }
  }


  //Signup a new user
  Future<UserCredential> signUp(String email, String password, context) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => value)
        .catchError((e) {
      ErrorHandler().errorDialog(context, e);
      return e;
    });
  }

  //Reset Password
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  //fb signin

//   fbSignIn() async {
//     final fb = FacebookLogin();

// // Log in
//     final res = await fb.logIn(permissions: [
//       FacebookPermission.publicProfile,
//       FacebookPermission.email,
//     ]);

// // Check result status
//     switch (res.status) {
//       case FacebookLoginStatus.success:
//         // Logged in

//         // Send access token to server for validation and auth
//         final FacebookAccessToken accessToken = res.accessToken;
//         final AuthCredential authCredential =
//             FacebookAuthProvider.credential(accessToken.token);
//         final result =
//             await FirebaseAuth.instance.signInWithCredential(authCredential);

//         // Get profile data
//         final profile = await fb.getUserProfile();
//         print('Hello, ${profile.name}! You ID: ${profile.userId}');

//         // Get user profile image url
//         final imageUrl = await fb.getProfileImageUrl(width: 100);
//         print('Your profile image: $imageUrl');

//         // Get email (since we request email permission)
//         final email = await fb.getUserEmail();
//         // But user can decline permission
//         if (email != null) print('And your email is $email');

//         break;
//       case FacebookLoginStatus.cancel:
//         // User cancel log in
//         break;
//       case FacebookLoginStatus.error:
//         // Log in failed
//         print('Error while log in: ${res.error}');
//         break;
//     }
//   }

}
