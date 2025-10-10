import 'package:flutter/material.dart';

import '../../core/common/error_text.dart';
import '../../core/utils.dart';
import 'authservice.dart';
import 'login_page.dart';

class ResetPassword extends StatefulWidget {
  final String routeName = '/reset';
  const ResetPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  late String email;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(key: formKey, child: _buildResetForm()));
  }

  _buildResetForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          // const SizedBox(height: 75.0),
          SizedBox(
            height: 55,
          ),
          Image.asset(
            "assets/images/logo.png",
            width: 120,
          ),
          Text(
            "Tripura Career Service",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
                fontSize: 20,
                height: 1),
          ),
          SizedBox(height: 24.0),
          Row(
            children: [
              Text(
                'Reset',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration:
                  inputDecuration(title: 'Email', icon: Icons.email_outlined),
              onChanged: (value) {
                email = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Email is required' : validateEmail(value)),

          Spacer(),
          ElevatedButton(
            onPressed: () {
              if (checkFields()) {
                try {
                  AuthService().resetPasswordLink(email);
                } catch (e) {
                  ErrorText(
                    error: e.toString(),
                  );
                  return;
                }
                showSnackBar(context, 'An email with reset code is sent');
                Navigator.of(context).pop();
              }
            },
            child: Text('Reset'),
          ),
          SizedBox(height: 20.0),
          // Other widgets like "Forgot Password" and "Sign Up" buttons
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Go Back',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
        ]));
  }
}
