// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../../core/common/error_text.dart';
// import '../../core/constants/firebase_constants.dart';
// import '../../core/failure.dart';
// import '../../core/providers/firebase_providers.dart';
// import '../../core/type_defs.dart';
// import '../../models/user_model.dart';

// final authRepositoryProvider = Provider(
//   (ref) => AuthRepository(
//     firestore: ref.read(firestoreProvider),
//     auth: ref.read(authProvider),
//     googleSignIn: ref.read(googleSignInProvider),
//   ),
// );

// class AuthRepository {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;
//   final GoogleSignIn _googleSignIn;

//   AuthRepository({
//     required FirebaseFirestore firestore,
//     required FirebaseAuth auth,
//     required GoogleSignIn googleSignIn,
//   })  : _auth = auth,
//         _firestore = firestore,
//         _googleSignIn = googleSignIn;

//   CollectionReference get _users =>
//       _firestore.collection(FirebaseConstants.usersCollection);

//   Stream<User?> get authStateChange => _auth.authStateChanges();
//   //  set authSignOut => _auth.signOut();

//   // FutureEither<UserModel> signInWithGoogle(bool isFromLogin) async {
//   //   try {
//   //     UserCredential userCredential;
//   //     if (kIsWeb) {
//   //       GoogleAuthProvider googleProvider = GoogleAuthProvider();
//   //       googleProvider
//   //           .addScope('https://www.googleapis.com/auth/contacts.readonly');
//   //       userCredential = await _auth.signInWithPopup(googleProvider);
//   //     } else {
//   //       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//   //       final googleAuth = await googleUser?.authentication;

//   //       final credential = GoogleAuthProvider.credential(
//   //         accessToken: googleAuth?.accessToken,
//   //         idToken: googleAuth?.idToken,
//   //       );

//   //       if (isFromLogin) {
//   //         userCredential = await _auth.signInWithCredential(credential);
//   //       } else {
//   //         userCredential =
//   //             await _auth.currentUser!.linkWithCredential(credential);
//   //       }
//   //     }

//   //     UserModel userModel;

//   //     if (userCredential.additionalUserInfo!.isNewUser) {
//   //       userModel = UserModel(
//   //         name: userCredential.user!.displayName ?? 'No Name',
//   //         profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
//   //         banner: Constants.bannerDefault,
//   //         uid: userCredential.user!.uid,
//   //         isAuthenticated: true,
//   //         karma: 0,
//   //         awards: [
//   //           'awesomeAns',
//   //           'gold',
//   //           'platinum',
//   //           'helpful',
//   //           'plusone',
//   //           'rocket',
//   //           'thankyou',
//   //           'til',
//   //         ],
//   //       );
//   //       await _users.doc(userCredential.user!.uid).set(userModel.toMap());
//   //     } else {
//   //       userModel = await getUserData(userCredential.user!.uid).first;
//   //     }
//   //     return right(userModel);
//   //   } on FirebaseException catch (e) {
//   //     throw e.message!;
//   //   } catch (e) {
//   //     return left(Failure(e.toString()));
//   //   }
//   // }

//   FutureEither<UserModel> signInWithEmail(
//     UserCredential userCredential,
//     UserModel? userData,
//   ) async {
//     try {
//       // if (kIsWeb) {
//       //   GoogleAuthProvider googleProvider = GoogleAuthProvider();
//       //   googleProvider
//       //       .addScope('https://www.googleapis.com/auth/contacts.readonly');
//       //   userCredential = await _auth.signInWithPopup(googleProvider);
//       // } else {
//       //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       //   final googleAuth = await googleUser?.authentication;

//       //   final credential = GoogleAuthProvider.credential(
//       //     accessToken: googleAuth?.accessToken,
//       //     idToken: googleAuth?.idToken,
//       //   );

//       //   if (isFromLogin) {
//       //     userCredential = await _auth.signInWithCredential(credential);
//       //   } else {
//       //     userCredential =
//       //         await _auth.currentUser!.linkWithCredential(credential);
//       //   }
//       // }

//       UserModel userModel;

//       if (userCredential.additionalUserInfo!.isNewUser && userData != null) {
//         userModel = userData;
//         debugPrint("ar: " + userData.toString());
//         await _users.doc(userCredential.user!.uid).set(userModel.toMap());
//       } else {
//         userModel = await getUserData(userCredential.user!.uid).first;
//       }
//       return right(userModel);
//     } on FirebaseException catch (e) {
//       throw e.message!;
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   // FutureEither<UserModel> signUpWithEmail(
//   //     UserCredential userCredential, UserModel user) async {
//   //   UserModel userModel;

//   //   userModel = user;
//   //   try{
//   //     await _users.doc(userCredential.user!.uid).set(userModel.toMap());
//   //     return right(userModel);
//   //   } on FirebaseException catch (e){
//   //     throw e.message!;
//   //   }catch(e){
//   //     return left(Failure(e.toString()));
//   //   }
//   // }

//   // FutureEither<UserModel> signInAsGuest() async {
//   // try {
//   // var userCredential = await _auth.signInAnonymously();

//   // UserModel userModel = UserModel(areaRoU: '', district: ''

//   // );

//   // await _users.doc(userCredential.user!.uid).set(userModel.toMap());

//   // return right(userModel);
//   // } on FirebaseException catch (e) {
//   // throw e.message!;
//   // } catch (e) {
//   // return left(Failure(e.toString()));
//   // }
//   // }

//   Stream<UserModel> getUserData(String uid) {
//     return _users.doc(uid).snapshots().map(
//         (event) {
//           debugPrint('uid'+ event.toString());
//          return UserModel.fromMap(event.data() as Map<String, dynamic>);
//   });

//   }

//   void logOut() async {
//     try {
//       await _googleSignIn.signOut();
//       try {
//         await _auth.signOut();
//         // ignore: empty_catches
//       } catch (e) {
//         ErrorText(error: '$e error in firebase auth signOut');
//       }
//       // ignore: empty_catches
//     } catch (e) {
//       ErrorText(error: '$e error in google signOut');
//     }
//   }
// }

// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import '../../core/common/error_text.dart';
import '../../core/constants/firebase_constants.dart';
import '../../core/failure.dart';
import '../../core/providers/firebase_providers.dart';
// import '../../core/type_defs.dart';
import '../../models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<Either<Failure, UserModel>> signInWithEmail(
    UserCredential userCredential,
    UserModel? userData,
  ) async {
    try {
      // Log start of user data process
      print('userModel Data start');

      // Initialize a variable for userModel
      UserModel userModel;

      // Check if the user is new and userData is provided
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        print('New userModel Data start');

        // Assign provided userData to userModel
        userModel = userData!;

        // Save the new user's data to Firestore
        await _users.doc(userCredential.user?.uid).set(userModel.toMap());

        print('userModel Data: ${userModel.toString()}');
      } else {
        print('Not New userModel Data start');

        // Fetch existing user data
        userModel = await getUserData(userCredential.user!.uid).first;

        print('Not New userModel Data: ${userModel.toString()}');
      }

      // Return success with userModel
      return Right(userModel);
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      print('Firebase error: ${e.message}');
      return Left(
          Failure(e.message ?? 'An unknown error occurred with Firebase'));
    } catch (e) {
      // Handle all other errors
      print('Error: $e');
      return Left(Failure(e.toString()));
    }
  }

  Future<void> createUserData(String uid, UserModel userData) async {
    try {
      await _firestore.collection('users').doc(uid).set(userData.toMap());
    } on FirebaseException catch (e) {
      // Handle any Firebase-specific errors
      throw Failure(e.message ?? 'An unknown error occurred');
    } catch (e) {
      // Handle any other errors
      throw Failure(e.toString());
    }
  }

  Stream<UserModel> getUserData(String uid) {
    var a = _users.doc(uid).snapshots().map((snapshot) =>
        UserModel.fromMap(snapshot.data() as Map<String, dynamic>));
    print('get firebase userModel ${a.first.toString()}');
    return a;
  }

  Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error during sign out: $e');
    }
  }
}
