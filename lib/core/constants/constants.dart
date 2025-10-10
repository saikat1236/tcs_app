import 'package:flutter/material.dart';

// colors
const black = Color(0xff1C1C1C);
const white = Color(0xffffffff);
const darkGrey = Color(0xff2B2B2B);
const lightGrey = Color.fromARGB(134, 89, 88, 88);
const bluishPink = Color.fromARGB(103, 163, 103, 213);
const pink = Color.fromARGB(109, 232, 85, 134);
const neonBlue = Color.fromARGB(146, 19, 218, 253);
const lightblue = Color.fromARGB(255, 169, 217, 252);
const lightyellow = Color.fromARGB(119, 223, 221, 215);
const Color greenColor = Color(0xFF00AF19);

// fonts
const String freehand = 'Freehand';
const String patrickHand = 'PatrickHand';

// gradient
const greyGradient = LinearGradient(
  colors: [darkGrey, lightyellow],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 0.4],
);

const blueGradient = SweepGradient(
  colors: [
    neonBlue,
    bluishPink,
    lightyellow,
  ],
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  stops: [0.3, 0.3, 0.2],
);

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const loginEmotePath = 'assets/images/loginEmote.png';
  static const googlePath = 'assets/images/google.png';
  static const facebookPath = 'assets/images/facebook.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    // FeedScreen(),
    // AddPostScreen(

    // ),
  ];

  static const IconData up =
      IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData down =
      IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  static const awardsPath = 'assets/images/awards';

  static const awards = {
    'awesomeAns': '${Constants.awardsPath}/awesomeanswer.png',
    'gold': '${Constants.awardsPath}/gold.png',
    'platinum': '${Constants.awardsPath}/platinum.png',
    'helpful': '${Constants.awardsPath}/helpful.png',
    'plusone': '${Constants.awardsPath}/plusone.png',
    'rocket': '${Constants.awardsPath}/rocket.png',
    'thankyou': '${Constants.awardsPath}/thankyou.png',
    'til': '${Constants.awardsPath}/til.png',
  };
}

class ColorSys {
  static Color primary = Color.fromARGB(125, 0, 0, 0);
  static Color gray = Color.fromARGB(255, 85, 85, 85);
  static Color secoundry = const Color.fromRGBO(198, 116, 27, 1);
  static Color secoundryLight = const Color.fromRGBO(226, 185, 141, 1);
}

class Strings {
  static var stepOneTitle = "Why Learning Needs Tracking";
  static var stepOneContent =
      "The difference between Study and Learning is only reading and understanding for it to be in memory for longer time but how do you know how much you have actually learned anything. That is the reason we need to start tracking our learning journey.";
  static var stepTwoTitle = "*Log what you'r Learning";
  static var stepTwoContent =
      "Keep track of all the courses and syllabuses or books and notes you are learning and keep your self in track with knowledge you must attain effeciently";
  static var stepThreeTitle = "Learning meet social";
  static var stepThreeContent =
      "Learning becomes way more fun when you meet like minded friends and chat, share, collaborate on what you are learning.";
}
