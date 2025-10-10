// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import '../../core/common/error_text.dart';
// import '../../core/utils.dart';
// import '../../models/user_model.dart';
// import '../repository/auth_repository.dart';

// final userProvider = StateProvider<UserModel?>((ref) => null);

// final authControllerProvider = StateNotifierProvider<AuthController, bool>(
//   (ref) => AuthController(
//     authRepository: ref.watch(authRepositoryProvider),
//     ref: ref,
//   ),
// );

// final authStateChangeProvider = StreamProvider((ref) {
//   final authController = ref.watch(authControllerProvider.notifier);
//   return authController.authStateChange;
// });

// final getUserDataProvider = StreamProvider.family((ref, String uid) {
//   final authController = ref.watch(authControllerProvider.notifier);
//   return authController.getUserData(uid);
// });

// class AuthController extends StateNotifier<bool> {
//   final AuthRepository _authRepository;
//   final Ref _ref;
//   AuthController({required AuthRepository authRepository, required Ref ref})
//       : _authRepository = authRepository,
//         _ref = ref,
//         super(false); // loading

//   Stream<User?> get authStateChange => _authRepository.authStateChange;

//   // void signInWithGoogle(BuildContext context, bool isFromLogin) async {
//   //   state = true;
//   //   final user = await _authRepository.signInWithGoogle(isFromLogin);
//   //   user.fold(
//   //     (l) => showSnackBar(context, l.message),
//   //     (userModel) =>
//   //         _ref.read(userProvider.notifier).update((state) => userModel),
//   //   );
//   //   state = false;
//   // }

// void signUpWithEmail(
//   BuildContext context, UserCredential userCredential, UserModel? userData) async {
//   state = true;
//   final user = await _authRepository.signInWithEmail(userCredential, userData);
//   user.fold(
//     (failure) {
//       // Log the detailed error message
//       debugPrint("Error: ${failure.message}");
//       showSnackBar(context, failure.message);
//     },
//     (userModel) {
//       _ref.read(userProvider.notifier).update((state) => userModel);
//     },
//   );
// }

//   void signUpWithEmailOLD(
//     BuildContext context, UserCredential userCredential, UserModel? userData) async {
//     state = true;
//     final user = await _authRepository.signInWithEmail(userCredential,userData);
//             debugPrint("ac: " + user.toString());
//     user.fold(
//       (l) => showSnackBar(context, l.message),
//       (userModel) =>
//           _ref.read(userProvider.notifier).update((state) => userModel),
//     );
//     // try {
//     //   final generalCommunity = _ref
//     //       .read(communityControllerProvider.notifier)
//     //       .getCommunityByName('general');

//     //   final productCommunity = _ref
//     //       .read(communityControllerProvider.notifier)
//     //       .getCommunityByName('finally store');

//     //   var gc, pc;
//     //   generalCommunity.listen((event) {
//     //     gc = event;
//     //   });

//     //   _ref.read(communityControllerProvider.notifier).newjoinCommunity(gc);

//     //   productCommunity.listen((event) {
//     //     pc = event;
//     //   });

//     //   _ref.read(communityControllerProvider.notifier).newjoinCommunity(pc);
//     // } catch (e) {
//     //   ErrorText(error: e.toString());
//     // }
//         state = false;

//   }

//   // void signInAsGuest(BuildContext context) async {
//   //   state = true;
//   //   try {
//   //     final user = await _authRepository.signInAsGuest();
//   //     user.fold(
//   //       (l) => showSnackBar(context, l.message),
//   //       (userModel) =>
//   //           _ref.read(userProvider.notifier).update((state) => userModel),
//   //     );
//   //   } finally {
//   //     late final Community gc;
//   //     try {
//   //       final generalCommunity = _ref
//   //           .read(communityControllerProvider.notifier)
//   //           .getCommunityByName('general');

//   //       generalCommunity.listen((event) {
//   //         gc = event;
//   //       });
//   //     } catch (e) {
//   //       ErrorText(error: e.toString());
//   //     } finally {
//   //       _ref
//   //           .read(communityControllerProvider.notifier)
//   //           .joinCommunity(gc, context);
//   //     }
//   //   }
//   //   state = false;
//   // }

//   Stream<UserModel> getUserData(String uid) {
//     return _authRepository.getUserData(uid);
//   }

//   void logout() async {
//     state = true;
//     _authRepository.logOut();
//     // _ref.read(authStateChange.)
//     state = false;
//     // _ref.read(userProvider.notifier).dispose();
//     // authStateChangeProvider;
//     // Navigator.popUntil(context, (route) => false)
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../repository/auth_repository.dart';


final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false); // Initial state set to false (not loading)

  Stream<User?> get authStateChange => _authRepository.authStateChange;

Future<void> signInWithEmail(BuildContext context, UserCredential userCredential) async {
  state = true; // Indicate loading, you might need to notify listeners or update the UI accordingly.
  debugPrint("Starting sign-in process...");

  try {
    final userResult = await _authRepository.signInWithEmail(userCredential, null);
    userResult.fold(
      (failure) {
        debugPrint("Error: ${failure.message}");
        // showSnackBar(context, failure.message); // Assuming showSnackBar is a method to display a snackbar
        debugPrint("Sign-in failed: ${failure.message}");
      },
      (userModel) {
        _ref.read(userProvider.notifier).update((_) => userModel); // Update the userProvider with the new userModel
        debugPrint("Sign-in successful with userData: $userModel");
      },
    );
  } catch (e) {
    debugPrint("An unexpected error occurred during sign-in: $e");
    // showSnackBar(context, "An unexpected error occurred. Please try again.");
  } finally {
    state = false; // Indicate loading complete, notify listeners or update UI as needed.
    debugPrint("Sign-in process completed.");
  }
}


Future<void> signInWithGoogle(BuildContext context, UserCredential userCred) async {
  final user = userCred.user;
  print("user: $user");
  if (user != null) {
    final userModel = UserModel(
      uid: user.uid,
      email: user.email ?? '',
      username: user.displayName ?? '',
      phoneNo: user.phoneNumber ?? '',
      dob: user.metadata.creationTime?.toIso8601String() ?? '',
      isAuthenticated: true,
      gender: '',
      religion: '',
      category: '',
      state: '',
      district: '',
      subDivision: '',
      areaRoU: '',
      pincode: 0,
      gaurdian: '',
      education: '',
      educationDetail: '',
      istraining: false,
      training: '',
      employmentStatus: false,
      occupation: '',
      skills: [],
      password: ''
    );

    _ref.read(userProvider.notifier).state = userModel; // ✅ Correct usage
  } else {
    debugPrint('Google Sign-In returned null user');
  }
}



Future<void> signUpWithEmail(
    BuildContext context, UserCredential userCredential, UserModel userData) async {
  state = true; // Indicate loading
  try {
    // Check if the user is newly created
    if (userCredential.additionalUserInfo!.isNewUser) {
      // Save the additional user details in Firestore
      await _authRepository.createUserData(userCredential.user!.uid, userData);
      _ref.read(userProvider.notifier).state = userData;
    } else {
      // If the user isn't new, you might want to handle this differently
      // showSnackBar(context, 'User already exists');
    }
  } on FirebaseException catch (e) {
    debugPrint( e.message ?? 'An error occurred');
  } catch (e) {
    debugPrint( e.toString());
  } finally {
    state = false; // Indicate loading complete
  }
}


  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logout() async {
    state = true; // Indicate loading
    await _authRepository.logOut();
    state = false; // Indicate loading complete
    // Reset userProvider to null
    _ref.read(userProvider.notifier).state = null;
  }

  // Future<void> createUser(UserModel userModel) async {
  //   await firestore.collection('users').doc(userModel.uid).set(userModel.toMap());
  // }

  // Future<void> registerUser(String email, String password, UserModel userModel) async {
  //   UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
  //   userModel.uid = credential.user!.uid;
  //   await createUser(userModel);
  // }
}
