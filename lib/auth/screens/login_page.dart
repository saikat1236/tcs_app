import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../controlller/auth_controller.dart';
import 'authservice.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 55),
            Image.asset("assets/images/logo.png", width: 120),
            Text(
              "Tripura Career Services",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
                fontSize: 20,
                height: 1,
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 400.0),
            Container(
              height: 60,
              width: 400,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  setState(() => isLoading = true);
                  try {
                    final userCred = await AuthService().signInWithGoogle(context, ref);
                    if (userCred != null) {
                      await ref.read(authControllerProvider.notifier).signInWithGoogle(context, userCred);
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showHome', true);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google sign-in failed: $e")),
                    );
                  } finally {
                    if (mounted) setState(() => isLoading = false);
                  }
                },
                icon: Image(image: AssetImage('assets/images/google.png'), width: 30, height: 20),
                label: isLoading
                    ? CircularProgressIndicator(color: Colors.blue)
                    : Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}