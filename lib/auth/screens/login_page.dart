import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcs_app_fixed/auth/controlller/auth_controller.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 120),
              Text(
                "Tripura Career Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(), // Replaces fixed height
              Container(
                height: 60,
                width: double.infinity,
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
                        print('Google sign-in successful, redirecting...');
                        await ref.read(authControllerProvider.notifier).signInWithGoogle(context, userCred);
                        // final prefs = await SharedPreferences.getInstance();
                        // prefs.setBool('showHome', true);
                      }
                    } catch (e) {
                      print('Google sign-in failed: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Google sign-in failed: $e")),
                      );
                    } finally {
                      if (mounted) setState(() => isLoading = false);
                    }
                  },
                  icon: Image.asset('assets/images/google.png', width: 30, height: 20),
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
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}