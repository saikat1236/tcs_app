import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart'; // Adjust the import path as necessary
import '../../models/user_model.dart'; // Adjust the import path as necessary
import '../controlller/auth_controller.dart';
import 'authservice.dart';
import 'reset.dart'; // Adjust the import path as necessary
import 'signup.dart'; // Adjust the import path as necessary
// import 'package:flutter_svg/flutter_svg.dart';


class LoginPage extends ConsumerStatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  // then pass `cred` to your provider controller to store user data

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return 'Enter Valid Email';
    return null;
  }

  void signIn() async {
    if (checkFields()) {
      setState(() => isLoading = true);
      try {
        UserCredential userCred = await AuthService().signIn(
          email,
          password,
          context,
        );
        await ref
            .read(authControllerProvider.notifier)
            .signInWithEmail(context, userCred);

        // Assuming this provider holds the sign-in state or user model
        final UserModel? userC = ref.watch(userProvider);

        if (userC != null) {
          // Proceed with navigation and preferences update only if userC is not null
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          debugPrint("Sign-in was not successful.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login not successfull! please check the entered credentials.",
              ),
            ),
          );
        }

      } on FirebaseAuthException catch (e) {
        debugPrint(e.message);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login failed")));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("An error occurred")));
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 55),
              Image.asset("assets/images/logo.png", width: 120),
              Text(
                "Tripura Career Service",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontSize: 20,
                  height: 1,
                ),
              ),
              SizedBox(height: 24.0),
              // Divider(),
              // Spacer(),
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
        

              // SizedBox(height: 20.0),
              SizedBox(height:400.0),
              Container(
                height: 60,
                width: 400,
                child:     ElevatedButton.icon(

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
                    );

                    // Proceed with saving or syncing user data
                    await ref
                        .read(authControllerProvider.notifier)
                        .signInWithGoogle(context, userCred);

                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google sign-in failed: $e")),
                    );
                  } finally {
                    if (mounted) setState(() => isLoading = false);
                  }
                },
                icon: Image(image: AssetImage('assets/images/google.png'), width: 30, height: 20,),

                label: isLoading
                    ? CircularProgressIndicator(color: Colors.blue)
                    : Text("Sign in with Google",
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

InputDecoration inputDecuration({
  required String title,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: title,
    prefixIcon: Icon(icon, color: Colors.grey.shade800),
    labelStyle: TextStyle(color: Colors.grey.shade800),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
  );
}
