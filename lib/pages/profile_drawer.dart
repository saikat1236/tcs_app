import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcs_app_fixed/auth/screens/login_page.dart';
import 'package:tcs_app_fixed/models/user_model.dart';
import 'package:tcs_app_fixed/pages/search_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/controlller/auth_controller.dart';

import 'add_job_post.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref, BuildContext context) async {
    try {
      ref.read(authControllerProvider.notifier).logout();
    } finally {
      // ref.read(userProvider.notifier).update((state) => null);
      // ref.read(userProvider.notifier).();
      // Navigator.popUntil(context, (route) => )
      // Navigator.of(context).popUntil(ModalRoute.withName('/'));
      // Navigator.of(context).pushNamedAndRemoveUntil(
      // OnBoarding.routeName, ModalRoute.withName('/'));
      try {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('showHome', false);
        // prefs.setBool('shoeLang', true);
      } finally {
        Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
      }
    }
  }


  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }



// ···

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        // final UserModel? userModel = ref.watch(userProvider.state).state;

  final UserModel? user = ref.watch(userProvider.state).state;
    // final isGuest = !user.isAuthenticated;
  List<String> emailList = ['praneshpal009@gmail.com', 'priyacsenita@gmail.com', 'debbarmakhalen175@gmail.com', 'employment.gov.tr@gmail.com', 'sowrajit1998@gmail.com'];

      // If user is null, you might want to show a different UI or perform some other action
  if (user == null) {
    // Handle the case where user is null
    // For example, return a different widget or show a login prompt
    return GestureDetector(
      onTap: (() => logOut(ref, context)),
      child: Center(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: currentTheme.canvasColor,
                    color: Color.fromARGB(255, 253, 253, 253),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(5, 10),
                    //     blurRadius: 15,
                    //     color: currentTheme.backgroundColor,
                    //   )
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Align children to the top
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.info_outline,
                          color: Color.fromRGBO(232, 26, 26, 1)),
                          // Spacer(),
                      Expanded(
                        // Wrap the Text widget with Expanded
                        child: Text(
                          "Your session is over, click to login again.",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              )
      
      );
  }
  print('which user:' + user.toString());

  // Rest of your code, now assuming 'user' is not null
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'desmp.app@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': '',
    }),
  );
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Color.fromRGBO(66, 133, 244, 1),
                      size: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            user.username??'N/A',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            user.email,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            user.phoneNo??"N/A",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: Colors.black,),
              
              SizedBox(
                height: 20,
              ),
              ListTile(
                  title: Text(
                    'Training And Skill Development',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.layers_outlined,
                    color: Color.fromRGBO(66, 133, 244, 1),
                  ),
                  onTap:()=> Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchPage(query: {'search': 'Skill'}))),
              ),
              // const Divider(),
              ListTile(
                  title: Text(
                    'Schemes/Loans Available For Self-employed',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.landslide_rounded,
                    color: Color.fromRGBO(66, 133, 244, 1),
                  ),
                  onTap: () =>Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(
                                query: {'search': 'Self-Employment'}))),
                                ),

              // const Divider(),
              ListTile(
                  title: Text(
                    'Employment Related Schemes/Misc. ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.emoji_flags_sharp,
                    color: Color.fromRGBO(66, 133, 244, 1),
                  ),
                  onTap: () => (
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchPage(query: {'search': 'scheme'})
                        )
                    )
                  )),

              
              ListTile(
                  title: const Text(
                    'Send Feedback',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.feedback_rounded,
                    color: Color.fromRGBO(66, 133, 244, 1),
                  ),
                  onTap: () async {
                    // const url = 'https://www.buymeacoffee.com/DhiSvajita';
                    // if (await canLaunchUrl(Uri.parse(url))) {

                    if (await launchUrl(emailLaunchUri)) {
                    } else {
                      throw 'Could not open $emailLaunchUri';
                    }
                  }),
              ListTile(
                  title: const Text(
                    'Contact Us :)',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.contact_page_rounded,
                    color: Color.fromRGBO(66, 133, 244, 1),
                  ),
                  onTap: () async {
                    // const url = 'https://www.buymeacoffee.com/DhiSvajita';
                    // if (await canLaunchUrl(Uri.parse(url))) {
                    if (await launchUrl(emailLaunchUri)) {
                    } else {
                      throw 'Could not open $emailLaunchUri';
                    }
                  }),
              ListTile(
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.logout_rounded, color: Colors.red),
                  onTap: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', false);
                  // prefs.setBool('shoeLang', true);
                  // AuthService().signOut();
                        ref.read(authControllerProvider.notifier).logout();

                } finally {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                }
                  }
          ),
          emailList.contains(user.email) ?
           ListTile(
                  title: Text(
                    'Add new Job Post ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.emoji_flags_sharp,
                    color: Color.fromRGBO(66, 133, 244, 1),
                  ),
                  onTap: () => (
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // SearchPage(query: {'search': 'scheme'})
                                CreateJobPostPage()
                        )
                    )
                  )) 
                  : Spacer(),
              // Switch.adaptive(
              //   value: ref.watch(themeNotifierProvider.notifier).mode ==
              //       ThemeMode.dark,
              //   onChanged: (val) => toggleTheme(ref),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
