// //app intro screen with indicator

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:routemaster/routemaster.dart';

// import '../../../../core/constants/constants.dart';
// import '../../../core/common/button.dart';
// import '../../../core/common/error_text.dart';
// // import '../../controlller/auth_controller.dart';
// import '../login_page.dart';

// class OnBoarding extends ConsumerStatefulWidget {
//   static const String routeName = '/onboarding';
//   const OnBoarding({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingState();
// }

// class _OnBoardingState extends ConsumerState<OnBoarding> {
//   late PageController _pageController;
//   int currentIndex = 0;
//   bool isLastPage = false;

//   @override
//   void initState() {
//     _pageController = PageController(initialPage: 0);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   // void signInAsGuest(BuildContext context) async {
//   //   try {
//   //     ref.read(authControllerProvider.notifier).signInAsGuest(context);
//   //   } finally {
//   //     try {
//   //       final prefs = await SharedPreferences.getInstance();
//   //       prefs.setBool('showHome', true);
//   //       // prefs.setBool('shoeLang', true);
//   //     } finally {
//   //       Navigator.of(context)
//   //           .push(MaterialPageRoute(builder: (context) => const HomePage()));
//   //     }
//   //   }
//   // }

//   // void signInWithGoogle(BuildContext context) {
//   //   ref.read(authControllerProvider.notifier).signInWithGoogle(context, true);
//   // }

//   // void navigateToSignIn(BuildContext context) {
//   //   Routemaster.of(context).push('/signIn');
//   // }

//   // void navigateToSignUp(BuildContext context) {
//   //   Routemaster.of(context).push('/signUp');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // var current = ref.read(provider)
//     return Scaffold(
//       // backgroundColor: Color.fromARGB(255, 123, 121, 121),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         // backgroundColor: const Color.fromARGB(255, 247, 224, 199),
//         actions: <Widget>[
//           Align(
//             alignment: Alignment.bottomRight,
//             child: TextButton(
//               onPressed: () {},
//               //  => signInAsGuest(context),
//               child: Text(
//                 'Access the Latest Government Job Services by Tripura Government.',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: <Widget>[
//           PageView(
//             onPageChanged: (int page) {
//               currentIndex = page;
//               if (page == 2) {
//                 isLastPage = true;
//               } else {
//                 isLastPage = false;
//               }
//               setState(() {});
//             },
//             controller: _pageController,
//             children: <Widget>[
//               makePage(
//                 image: 'assets/images/learning_stress.png',
//                 title: Strings.stepOneTitle,
//                 content: Strings.stepOneContent,
//                 signInMethod: 'Sign in with Email',
//                 icon: const Icon(
//                   Icons.email,
//                   color: Colors.black,
//                 ),
//                 onPress: () {
//                   // return Navigator.of(context).pushNamed(LoginPage.routeName);
//                   // return Navigator.of(context).push(MaterialPageRoute(
//                   // builder: (context) => AuthService().handleAuth(context)));
//                 },
//               ),
//               makePage(
//                   reverse: true,
//                   image: 'assets/images/writing.gif',
//                   title: Strings.stepTwoTitle,
//                   content: Strings.stepTwoContent,
//                   signInMethod: 'Sign in with Google',
//                   icon: Image.asset(
//                     Constants.googlePath,
//                     width: 35,
//                   ),
//                   onPress: () {}
//                   // => signInWithGoogle(context),
//                   ),
//               makePage(
//                   image: 'assets/images/suprise.png',
//                   title: Strings.stepThreeTitle,
//                   content: Strings.stepThreeContent,
//                   signInMethod: 'Want to register new account',
//                   // icon: Image.asset(
//                   //   Constants.facebookPath,
//                   //   width: 35,
//                   // ),
//                   icon: const Icon(
//                     Icons.email_outlined,
//                     color: Colors.black,
//                   ),
//                   onPress: () {
//                     // return Navigator.of(context).push(MaterialPageRoute(
//                     //     builder: (context) => const MainHomeScreen()));
//                   }),
//             ],
//           ),
//           // Container(
//           //   margin: const EdgeInsets.only(bottom: 60),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: _buildIndicator(),
//           //   ),
//           // ),
//           Positioned(
//             bottom: 10,
//             top: 500,
//             // color: Colors.amber,
//             // margin: const EdgeInsets.only(bottom: 180),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: _buildIndicator(),
//             ),
//           ),
//           isLastPage
//               ? Padding(
//                   padding: const EdgeInsets.all(45.0),
//                   child: BorderedButton(
//                       text: ' Lets Get Started,',
//                       onPress: () async {
//                         try {
//                           final prefs = await SharedPreferences.getInstance();
//                           // prefs.setBool('showHome', true);
//                           prefs.setBool('shoeLogin', true);
//                         } catch (e) {
//                           ErrorText(
//                             error: e.toString(),
//                           );
//                         } finally {
//                           Navigator.of(context).pushReplacement(MaterialPageRoute(
//                               builder: (context) => const LoginPage()));
//                         }
//                         // return Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) => const LoginPage()));
//                       },
//                       icon: const Icon(
//                         Icons.airline_seat_recline_normal_outlined,
//                         color: Colors.black,
//                       )),
//                 )
//               // ? AnimatedContainer(
//               //     duration: const Duration(milliseconds: 600),
//               //     curve: Curves.easeIn,
//               //     margin: const EdgeInsets.only(left: 20, bottom: 20),
//               //     width: MediaQuery.of(context).size.width / 1.2,
//               //     child: ElevatedButton(
//               //         style: ElevatedButton.styleFrom(
//               //             shape: RoundedRectangleBorder(
//               //               borderRadius: BorderRadius.circular(20),
//               //             ),
//               //             foregroundColor: Colors.white,
//               //             backgroundColor: const Color.fromARGB(255, 93, 52, 237),
//               //             minimumSize: const Size.fromHeight(50)),
//               //         child: const Text(
//               //           "Get Started",
//               //           style: TextStyle(fontSize: 20),
//               //         ),
//               //         onPressed: () async {
//               //           try {
//               //             // final prefs = await SharedPreferences.getInstance();
//               //             // prefs.setBool('showLang', true);
//               //           } finally {
//               //             Navigator.of(context).pushNamed(LoginPage.routeName);
//               //           }
//               //         }),
//               //   )
//               : Container(
//                   margin: const EdgeInsets.only(bottom: 40),
//                   height: 50,
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TextButton(
//                           onPressed: () => _pageController.jumpToPage(2),
//                           child: const Text(
//                             'Skip',
//                             // style: TextStyle(color: Colors.black26),
//                           )),
//                       TextButton(
//                           onPressed: () => _pageController.nextPage(
//                               duration: const Duration(milliseconds: 500),
//                               curve: Curves.easeInOut),
//                           child: const Text(
//                             'Next ➡️',
//                             // style: TextStyle(color: Colors.black),
//                           ))
//                     ],
//                   ),
//                 )
//         ],
//       ),
//     );
//   }

//   Widget makePage(
//       {image, title, content, reverse = false, signInMethod, icon, onPress}) {
//     return Container(
//       // color: const Color.fromARGB(255, 247, 224, 199),
//       // color: ref.watch(themeNotifierProvider).appBarTheme.backgroundColor,
//       color: Colors.white,
//       padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           // !reverse
//           //     ? Column(
//           //         children: <Widget>[
//           //           Padding(
//           //             padding: const EdgeInsets.symmetric(horizontal: 15),
//           //             child: Image.asset(image),
//           //           ),
//           //           const SizedBox(
//           //             height: 5,
//           //           ),
//           //         ],
//           //       )
//           //     : const SizedBox(),
//           Text(
//             title,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             content,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 letterSpacing: 1,
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontFamily: 'trueno',
//                 fontWeight: FontWeight.w400),
//           ),
//           // reverse
//           //     ? Column(
//           //         children: <Widget>[
//           //           const SizedBox(
//           //             height: 30,
//           //           ),
//           //           Padding(
//           //             padding: const EdgeInsets.symmetric(horizontal: 20),
//           //             child: Image.asset(image),
//           //           ),
//           //         ],
//           //       )
//           //     : const SizedBox(),
//           const SizedBox(
//             height: 70,
//           ),
//           // BorderedButton(
//           //   text: signInMethod,
//           //   onPress: onPress,
//           //   icon: icon,
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: 6,
//       width: isActive ? 30 : 6,
//       margin: const EdgeInsets.only(right: 5),
//       decoration: BoxDecoration(
//           color: ColorSys.secoundry, borderRadius: BorderRadius.circular(5)),
//     );
//   }

//   List<Widget> _buildIndicator() {
//     List<Widget> indicators = [];
//     for (int i = 0; i < 3; i++) {
//       if (currentIndex == i) {
//         indicators.add(_indicator(true));
//       } else {
//         indicators.add(_indicator(false));
//       }
//     }

//     return indicators;
//   }
// }
