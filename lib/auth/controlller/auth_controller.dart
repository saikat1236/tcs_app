import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final getUserDataProvider = StreamProvider.family<UserModel?, String>((ref, uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false) {
    // Listen to auth state changes to update userProvider
    _ref.listen(authStateChangeProvider, (previous, next) {
      next.when(
        data: (user) async {
          if (user != null) {
            final userData = await _authRepository.getUserData(user.uid).first;
            _ref.read(userProvider.notifier).state = userData;
            debugPrint("Updated userProvider with: $userData");
          } else {
            _ref.read(userProvider.notifier).state = null;
            debugPrint("Cleared userProvider due to null user");
          }
        },
        loading: () => debugPrint("Auth state loading"),
        error: (e, _) => debugPrint("Auth state error: $e"),
      );
    });
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;
Future<void> restoreSession(BuildContext context) async {
  try {
    final googleUser = await GoogleSignIn().signInSilently();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      // Update userProvider as in signInWithGoogle
      final userData = await _authRepository.getUserData(userCred.user!.uid).first;
      _ref.read(userProvider.notifier).state = userData;
    }
  } catch (e) {
    debugPrint('Silent re-auth failed: $e');
    // Optionally logout or show login
  }
}
  Future<void> signInWithGoogle(BuildContext context, UserCredential userCred) async {
    state = true;
    try {
      final user = userCred.user;
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
        );
        _ref.read(userProvider.notifier).state = userModel;
        debugPrint("Google Sign-In user model set: $userModel");
      } else {
        debugPrint("Google Sign-In returned null user");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google Sign-In failed")));
      }
    } catch (e) {
      debugPrint("Error during Google Sign-In: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google Sign-In error: $e")));
    } finally {
      state = false;
    }
  }

  Future<void> signUpWithGoogle(BuildContext context, UserCredential userCredential, UserModel userData) async {
    state = true;
    try {
      await _authRepository.createUserData(userCredential.user!.uid, userData);
      _ref.read(userProvider.notifier).state = userData;
      debugPrint("User created and data saved: $userData");
    } catch (e) {
      debugPrint("Error during signup: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup error: $e")));
    } finally {
      state = false;
    }
  }

  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  // Future<void> logout() async {
  //   state = true;
  //   try {
  //     await _authRepository.logOut();
  //     _ref.read(userProvider.notifier).state = null;
  //     debugPrint("User logged out");
  //   } catch (e) {
  //     debugPrint("Logout error: $e");
  //   } finally {
  //     state = false;
  //   }
  // }
  Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('showHome', false);
  await _authRepository.logOut(); // Calls AuthService.signOut()
  _ref.read(userProvider.notifier).state = null;
}
}