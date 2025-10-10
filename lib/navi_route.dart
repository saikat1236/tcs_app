
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/screens/login_page.dart';
// import 'auth/screens/onboarding/on_boarding.dart';
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
    // case OnBoarding.routeName:
    //   // final verificationId = settings.arguments as String;
    //   return MaterialPageRoute(
    //     builder: (context) => const OnBoarding(),
      // );
    case SignupPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );
    case HomePage.routeName:
    // final arguments = settings.arguments as Map<String, dynamic>?;
    // final isReply = arguments?['isReply'];
      return MaterialPageRoute(
    builder: (context) => const HomePage(),
    );
    // case TrackScreen.routeName:
    //   return MaterialPageRoute(builder: (context) => const TrackScreen());
    // case CommunityListScreen.routeName:
    //   return MaterialPageRoute(
    //       builder: (context) => const CommunityListScreen());
    // case CommunityFeedScreen.routeName:
    //   return MaterialPageRoute(
    //     builder: (context) => const CommunityFeedScreen(),
    //   );
    // // case HomeScreen.routeName:
    // // final arguments = settings.arguments as Map<String, dynamic>;
    // // final name = arguments['name'];
    // // final chatID = arguments['chatID'];
    // // final isGroupChat = arguments['isGroupChat'];
    // // final profilePic = arguments['profilePic'];
    // // final phoneNumber = arguments['phoneNumber'];
    // // final profilePicProvider = arguments['profilePicProvider'];
    // // final participantPhoneNumbers = arguments['participantPhoneNumbers'];
    // // return SlidingMaterialPageRoute(const HomeScreen(
    // // name: name,
    // // chatID: chatID,
    // // isGroupChat: isGroupChat,
    // // profilePic: profilePic,
    // // phoneNumber: phoneNumber,
    // // profilePicProvider: profilePicProvider,
    // // participantPhoneNumbers: participantPhoneNumbers),
    // // ));
    // case SubjectScreen.routeName:
    //   final subject = settings.arguments as Subject;
    //   // final subjectId = arguments['subjectId'];
    //   return MaterialPageRoute(
    //     builder: (context) => SubjectScreen(
    //       subject: subject,
    //     ),
    //   );
    // case CreateSubjectScreen.routeName:
    //   final course = settings.arguments as Course;
    //   return MaterialPageRoute(
    //       builder: (context) => CreateSubjectScreen(course: course));

    // case EditCourseScreen.routeName:
    //   final course = settings.arguments as Course;
    //   return MaterialPageRoute(
    //       builder: (context) => EditCourseScreen(course: course));
    // // case CreateTopicScreen.routeName:
    // //   final course = settings.arguments as Subject;
    // //   return SlidingMaterialPageRoute(CreateTopicScreen(: course));

    // case CourseScreen.routeName:
    //   final course = settings.arguments as Course;
    //   // final courseId = arg['courseId'];
    //   return MaterialPageRoute(
    //     builder: (context) => CourseScreen(
    //       course: course,
    //     ),
    //   );
    // case CreateTrack.routeName:
    //   // final uid = settings.arguments as String;
    //   return MaterialPageRoute(
    //       builder: (context) => const CreateTrack());

    // case AddPostScreen.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;
    //   final topicId = arguments['topicId'];
    //   final topicTitle = arguments['topicTitle'];
    //   return MaterialPageRoute(
    //     builder: (context) => AddPostScreen(
    //       topicId: topicId,
    //       topicTitle: topicTitle,
    //     ),
    //   );
    // case AddPostTypeScreen.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;
    //   final topicId = arguments['topicId'];
    //   final topicTitle = arguments['topicTitle'];
    //   final type = arguments['type'];
    //   return MaterialPageRoute(
    //     builder: (context) => AddPostTypeScreen(
    //       topicId: topicId,
    //       topicTitle: topicTitle,
    //       type: type,
    //     ),
    //   );
    // case CommunityScreen.routeName:
    //   final arg = settings.arguments as Map<String, dynamic>;
    //   final name = arg['name'];
    //   return MaterialPageRoute(
    //       builder: (context) => CommunityScreen(name: name));

    // case CreateCommunityScreen.routeName:
    //   // final name = settings.arguments as String;
    //   return MaterialPageRoute(
    //       builder: (context) => const CreateCommunityScreen());
    // case EditCommunityScreen.routeName:
    //   final name = settings.arguments as String;
    //   return MaterialPageRoute(
    //       builder: (context) => EditCommunityScreen(name: name));

    // case UserProfileScreen.routeName:
    //   final arg = settings.arguments as Map<String, dynamic>;
    //   final uid = arg['uid'];
    //   return MaterialPageRoute(
    //       builder: (context) => UserProfileScreen(uid: uid));
    // case EditProfileScreen.routeName:
    //   final arg = settings.arguments as Map<String, dynamic>;
    //   final uid = arg['uid'];
    //   return MaterialPageRoute(
    //       builder: (context) => EditProfileScreen(uid: uid));

    // case CommentsScreen.routeName:
    //   final arg = settings.arguments as Map<String, dynamic>;
    //   final postId = arg['postId'];
    //   return MaterialPageRoute(
    //       builder: (context) => CommentsScreen(postId: postId));

    // case ModToolsScreen.routeName:
    //   final name = settings.arguments as String;
    //   return MaterialPageRoute(
    //       builder: (context) => ModToolsScreen(name: name));
    // case AddModsScreen.routeName:
    //   final name = settings.arguments as String;
    //   return MaterialPageRoute(builder: (context) => AddModsScreen(name: name));
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorText(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
