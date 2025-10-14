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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 110,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  elevation: 0,
                  child: Container(
                    color: Colors.white,
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/images/logo4.png',
                                height: 60,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Directorate of Employment",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                  ),
                                  Text("Services & Manpower Planning",
                                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // const Spacer(),
   
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Tripura Career Services',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                           
                  
                            
                          ],
                        ),
              Image.asset("assets/images/logo.png", width: 200),
              Text(
                "A Hub of Career Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24.0),

              // Text(
              //   'Login',
              //   style: TextStyle(
              //     fontSize: 25.0,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
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
                      final userCred = await AuthService().signInWithGoogle(
                        context,
                        ref,
                      );
                      if (userCred != null) {
                        print('Google sign-in successful, redirecting...');
                        await ref
                            .read(authControllerProvider.notifier)
                            .signInWithGoogle(context, userCred);
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
                  icon: Image.asset(
                    'assets/images/google.png',
                    width: 30,
                    height: 20,
                  ),
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
