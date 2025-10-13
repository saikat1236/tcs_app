import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcs_app_fixed/auth/controlller/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../controlller/auth_controller.dart';
import 'authservice.dart';

class SignupPage extends ConsumerStatefulWidget {
  static const String routeName = '/signup';
  final UserCredential userCredential;

  const SignupPage({super.key, required this.userCredential});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final formKey = GlobalKey<FormState>();
  String dateinput = "";
  DateTime? pickedDate;

  String? username;
  String email = '';
  String? phoneNo;

  String? dob;
  late String uid;
  bool? isAuthenticated;
  String? gender;
  String? religion;

  String? category;
  String? educationDetail;

  String? state;
  String? district;
  String? subDivision;
  String? areaRoU;
  int? pincode;
  String? gaurdian;
  String? education;
  String? istraining;
  String? training;

  bool? employmentStatus;
  String? occupation;
  List<String>? skills;

  bool checkFields() {
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
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  var genderItems = [
    'Male',
    'Female',
    'Others',
  ];
  var religionItems = [
    'Hindu',
    'Muslim',
    'Christian',
    'Sikh',
    'Buddhist',
    'Jain',
    'Others'
  ];
  var categoryItems = [
    'UR',
    'SC',
    'ST',
    'OBC',
  ];
  var areaRoUItems = ['Urban', 'Rural'];
  var educationItems = [
    'Upto class 9',
    'class 10 passed',
    'class 12 passed',
    'Diploma after 10',
    'Diploma after 12',
    'Graduation',
    'P.G. Diploma',
    'Post Graduation',
    'Phd. or Specialist'
  ];
  var stateItems = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];
  var trainingItems = ['ITI', "PSU", 'PMKVY', 'DDUGKY', 'Others'];
  var employmentStatusItem = ['employed', 'unemployment'];

  @override
  void initState() {
    dateinput = "";
    super.initState();
    // Pre-fill email, username, and uid from Google Sign-In
    final user = widget.userCredential.user;
    if (user != null) {
      email = user.email ?? '';
      username = user.displayName;
      uid = user.uid;
    }
  }

  int calculateAge(DateTime? birthDate) {
    if (birthDate == null) {
      return 1;
    }
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (birthDate.month > currentDate.month) {
      age--;
    } else if (currentDate.month == birthDate.month) {
      if (birthDate.day > currentDate.day) {
        age--;
      }
    }
    return age;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 55),
                Image.asset(
                  "assets/images/logo.png",
                  width: 120,
                ),
                Text(
                  "Tripura Career Services",
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
                      'Complete Your Profile',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: email,
                  enabled: false, // Disable email field as it's from Google Sign-In
                  decoration: inputDecuration(
                      title: 'Email', icon: Icons.email_outlined),
                  validator: (value) => value!.isEmpty
                      ? 'Email is required'
                      : validateEmail(value),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: inputDecuration(
                        title: 'Phone Number', icon: Icons.phone),
                    onChanged: (value) {
                      phoneNo = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Phone Number is required' : null),
                SizedBox(height: 12.0),
                TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: username,
                    decoration:
                        inputDecuration(title: 'Full Name', icon: Icons.person),
                    onChanged: (value) {
                      username = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Your Name is required' : null),
                SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () async {
                    pickedDate = await showDatePicker(
                        context: context,
                        initialDatePickerMode: DatePickerMode.year,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2040));
                    if (pickedDate != null && calculateAge(pickedDate) >= 16) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate!);
                      setState(() => dateinput = formattedDate);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid date of birth (age must be 16 or older).")),
                      );
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade800,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 8),
                          Text(dateinput == "" ? 'Date of Birth' : dateinput),
                        ],
                      )),
                ),
                SizedBox(height: 12.0),
                DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(15),
                  style: TextStyle(color: Colors.black),
                  dropdownColor: Color.fromARGB(255, 255, 255, 255),
                  items: genderItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Your gender is required' : null,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: dropDownOutlineBorder(),
                    focusedBorder: focusBorderDropDown(),
                  ),
                ),
                SizedBox(height: 12.0),
                _buildSignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder focusBorderDropDown() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
          color: Color.fromARGB(255, 36, 84, 241),
          width: 2,
          style: BorderStyle.solid),
    );
  }

  OutlineInputBorder dropDownOutlineBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
            color: Colors.grey.shade800, width: 2, style: BorderStyle.solid));
  }

  Widget _buildSignupForm() {
    return Column(children: [
      DropdownButtonFormField(
        items: categoryItems.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            category = newValue!;
          });
        },
        validator: (value) =>
            value == null ? 'Your category is required' : null,
        decoration: InputDecoration(
            labelText: 'Category',
            border: dropDownOutlineBorder(),
            focusedBorder: focusBorderDropDown()),
      ),
      SizedBox(height: 10),
      DropdownButtonFormField(
        items: religionItems.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            religion = newValue!;
          });
        },
        validator: (value) =>
            value == null ? 'Your religion is required' : null,
        decoration: InputDecoration(
            labelText: 'Religion',
            border: dropDownOutlineBorder(),
            focusedBorder: focusBorderDropDown()),
      ),
      SizedBox(height: 10),
      DropdownButtonFormField(
        items: stateItems.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            state = newValue!;
          });
        },
        validator: (value) => value == null ? 'Your State is required' : null,
        decoration: InputDecoration(
            labelText: 'Select your State',
            border: dropDownOutlineBorder(),
            focusedBorder: focusBorderDropDown()),
      ),
      SizedBox(height: 10),
      TextFormField(
          keyboardType: TextInputType.text,
          decoration: inputDecuration(
              title: 'District', icon: Icons.location_city_rounded),
          onChanged: (value) {
            district = value;
          },
          validator: (value) => value!.isEmpty ? 'District is required' : null),
      SizedBox(height: 10),
      TextFormField(
          keyboardType: TextInputType.text,
          decoration: inputDecuration(
              title: 'Sub-Division', icon: Icons.location_city_outlined),
          onChanged: (value) {
            subDivision = value;
          },
          validator: (value) =>
              value!.isEmpty ? 'Your sub division is required' : null),
      SizedBox(height: 10),
      DropdownButtonFormField(
        items: areaRoUItems.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            areaRoU = newValue!;
          });
        },
        validator: (value) => value == null ? 'State your area type' : null,
        decoration: InputDecoration(
            labelText: 'Area type',
            labelStyle: TextStyle(
                fontFamily: 'Trueno', fontSize: 12.0, color: Colors.black),
            border: dropDownOutlineBorder(),
            focusedBorder: focusBorderDropDown()),
      ),
      SizedBox(height: 10),
      TextFormField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration:
              inputDecuration(title: 'Pincode', icon: Icons.location_city),
          onChanged: (value) {
            pincode = int.tryParse(value);
          },
          validator: (value) =>
              value!.isEmpty ? 'Your area pincode is required' : null),
      SizedBox(height: 10),
      TextFormField(
          keyboardType: TextInputType.text,
          decoration: inputDecuration(
              title: 'Guardian/Father name', icon: Icons.person_2),
          onChanged: (value) {
            gaurdian = value;
          },
          validator: (value) =>
              value!.isEmpty ? 'Your guardian name is required' : null),
      SizedBox(height: 10),
      DropdownButtonFormField(
        borderRadius: BorderRadius.circular(15),
        style: TextStyle(color: Colors.black),
        dropdownColor: Color.fromARGB(255, 255, 255, 255),
        items: educationItems.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            education = newValue!;
          });
        },
        validator: (value) =>
            value == null ? 'Your education is required' : null,
        decoration: InputDecoration(
            labelText: 'Select your Education qualification',
            border: dropDownOutlineBorder(),
            focusedBorder: focusBorderDropDown()),
      ),
      SizedBox(height: 10),
      TextFormField(
          decoration: inputDecuration(title: 'Education', icon: Icons.school),
          onChanged: (value) {
            educationDetail = value;
          },
          validator: (value) =>
              value!.isEmpty ? 'Your education detail is required' : null),
      SizedBox(height: 10),
      DropdownButtonFormField(
        items: employmentStatusItem.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            employmentStatus = newValue == 'employed' ? true : false;
          });
        },
        validator: (value) =>
            value == null ? 'Your employment status is required' : null,
        decoration: InputDecoration(
            labelText: 'Employment Status',
            border: dropDownOutlineBorder(),
            focusedBorder: focusBorderDropDown()),
      ),
      SizedBox(height: 10),
      TextFormField(
        decoration:
            inputDecuration(title: 'Add your Skills', icon: Icons.settings),
        onChanged: (value) {
          skills = value.split(',');
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        decoration: inputDecuration(
            title: 'Add your Occupation', icon: Icons.cases_outlined),
        onChanged: (value) {
          occupation = value;
        },
      ),
      SizedBox(height: 12),
      RadioMenuButton(
          trailingIcon: Icon(Icons.settings_ethernet_sharp),
          style: ButtonStyle(
            shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            elevation: WidgetStatePropertyAll<double>(1),
            iconColor: WidgetStatePropertyAll<Color>(Colors.green),
          ),
          toggleable: true,
          value: 'Yes',
          groupValue: istraining,
          onChanged: (value) {
            setState(() {
              istraining = value ?? 'No';
            });
          },
          child: Text('Have you done any skill training, Yes?')),
      SizedBox(height: 5),
      if (istraining == 'Yes')
        DropdownButtonFormField(
          items: trainingItems.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              training = newValue;
            });
          },
          decoration: InputDecoration(
              labelText: 'Which Training Institute',
              border: dropDownOutlineBorder(),
              focusedBorder: focusBorderDropDown()),
        ),
      SizedBox(height: 40),
      GestureDetector(
        onTap: () async {
          if (!isLoading && checkFields()) {
            setState(() => isLoading = true);
            try {
              skills = skills ?? [];
              isAuthenticated = true;
              dob = dateinput;

              UserModel userData = UserModel(
                category: category ?? '',
                educationDetail: educationDetail ?? '',
                username: username ?? '',
                email: email,
                phoneNo: phoneNo ?? '',
                dob: dob ?? '',
                uid: widget.userCredential.user!.uid,
                isAuthenticated: isAuthenticated ?? false,
                gender: gender ?? '',
                religion: religion ?? '',
                state: state ?? '',
                district: district ?? '',
                subDivision: subDivision ?? '',
                areaRoU: areaRoU ?? '',
                pincode: pincode ?? 0,
                gaurdian: gaurdian ?? '',
                education: education ?? '',
                istraining: istraining == 'Yes',
                training: training ?? '',
                employmentStatus: employmentStatus ?? false,
                occupation: occupation ?? '',
                skills: skills ?? [],
              );

              await ref
                  .read(authControllerProvider.notifier)
                  .signUpWithGoogle(context, widget.userCredential, userData);

              // final prefs = await SharedPreferences.getInstance();
              // prefs.setBool('showHome', true);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Profile completion failed: $e")),
              );
            } finally {
              setState(() => isLoading = false);
            }
          }
        },
        child: SizedBox(
            height: 50.0,
            child: Material(
                borderRadius: BorderRadius.circular(25.0),
                color: Color.fromARGB(255, 36, 84, 241),
                elevation: 3.0,
                child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Complete Profile',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
      ),
      SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'By continuing you agree with our ',
            style: TextStyle(color: Colors.black54),
          ),
          InkWell(
              onTap: () {
                launchURL();
              },
              child: Text('Privacy Policy',
                  style: TextStyle(
                      color: Color.fromARGB(255, 36, 84, 241),
                      decoration: TextDecoration.underline))),
        ],
      ),
      SizedBox(height: 18),
      InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text('Go back',
              style: TextStyle(
                color: Color.fromARGB(255, 36, 84, 241),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
      SizedBox(height: 40.0),
    ]);
  }

  void launchURL() async {
    const url = 'https://textmi.in/privacy-policy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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