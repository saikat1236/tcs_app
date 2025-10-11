import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/screens/login_page.dart';
import 'auth/screens/signup.dart';
import 'core/common/error_text.dart';
import 'main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MyApp.routeName:
      final sp = settings.arguments as SharedPreferences;
      return MaterialPageRoute(
          builder: (_) => MyApp(
                sharedPreferences: sp,
              ));
    case LoginPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case SignupPage.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      final userCredential = args?['userCredential'];
      if (userCredential != null) {
        return MaterialPageRoute(
          builder: (context) => SignupPage(userCredential: userCredential),
        );
      }
      // Fallback for cases where SignupPage is accessed without userCredential
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorText(error: 'Invalid navigation: UserCredential required'),
        ),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorText(error: 'This page doesn\'t exist'),
        ),
      );
  }
}