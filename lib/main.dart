import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcs_app_fixed/auth/controlller/auth_controller.dart';

// import 'auth/controller/auth_controller.dart';
import 'auth/screens/login_page.dart';
import 'core/common/error_text.dart';
import 'core/common/loader.dart';
import 'firebase_options.dart';
import 'navi_route.dart';
import 'pages/mainHome.dart';
// import 'theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      child: MyApp(sharedPreferences: sharedPreferences),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  static const routeName = '/';
  final SharedPreferences sharedPreferences;

  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MyApp> {
  DateTime? lastBackPressTime;

  @override
  void initState() {
    super.initState();
    // secureScreen();
  }

  // Future<void> secureScreen() async {
  //   await FlutterWindowManager.addFlags(
  //       FlutterWindowManager.FLAG_TRANSLUCENT_STATUS);
  //   await FlutterWindowManager.addFlags(
  //       FlutterWindowManager.FLAG_TRANSLUCENT_NAVIGATION);
  // }

  @override
  Widget build(BuildContext context) {
    final showHome = widget.sharedPreferences.getBool('showHome') ?? false;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tripura Career Service',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue, // Button color
            textTheme: ButtonTextTheme.primary, // Text color
            height: 50,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 36, 84, 241), // Button color
              foregroundColor: Colors.white, // Text color
              minimumSize: Size.fromHeight(50), // Button height
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo.shade800,
            foregroundColor: Colors.white,
          )
          // Define other properties of the light theme here
          ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode
          .light, // Can be ThemeMode.light or ThemeMode.dark to override the system setting

      onGenerateRoute: generateRoute,
      home: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          final now = DateTime.now();
          if (lastBackPressTime == null ||
              now.difference(lastBackPressTime!) > Duration(seconds: 2)) {
            lastBackPressTime = now;
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Press back again to exit'),
                  duration: Duration(seconds: 2),
                ),
              );
          } else {
            SystemNavigator
                .pop(); // Directly exit the app if pressed again within 2 seconds
          }
          // No need to return anything as onPopInvoked expects a void return
        },
        child: showHome ? const HomePage() : const LoginPage(),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  static const routeName = 'homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangeProvider);

    return authState.when(
      data: (user) => user != null ? const MainHome() : const LoginPage(),
      error: (error, _) => ErrorText(error: error.toString()),
      loading: () => const Loader(),
    );
  }
}


// class _UserScreen extends ConsumerWidget {
//   final String userId;

//   const _UserScreen(this.userId, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userModelAsyncValue = ref.watch(getUserDataProvider(userId));

//     return userModelAsyncValue.when(
//       data: (userModel) {
//         ref.read(userProvider.notifier).state = userModel;
//         return const MainHome(); // Or any other widget based on the user data
//       },
//       error: (error, _) => ErrorText(error: error.toString()),
//       loading: () => const Loader(),
//     );
//   }
// }


// class _HomePageState extends ConsumerState<HomePage> {
//   UserModel? userModel;

//   void getData(WidgetRef ref, User data) async {
//     userModel = await ref
//         .watch(authControllerProvider.notifier)
//         .getUserData(data.uid)
//         .first;

//     ref.read(userProvider.notifier).update((state) => userModel);
//     // ref.watch(userProvider);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ref.watch(authStateChangeProvider).when(
//         data: ((data) {
//           // debugPrint(data.toString());
//           return FutureBuilder(
//               future: ref.watch(authStateChangeProvider.future),
//               initialData: ref.watch(userProvider),
//               // : FirebaseAuth.instance.authStateChanges(),
//               builder: (context, user) {
//                 if (data != null) getData(ref, data);
//                 // if (user.hasData) getData(ref, user.data as User);
//                 return userModel == null ? const Loader() : const MainHome();
//                 //  MaterialApp(
//                 //     debugShowCheckedModeBanner: false,
//                 //     title: 'Final Vedas',
//                 //     theme: ref.watch(themeNotifierProvider),
//                 //     onGenerateRoute: ((settings) => generateRoute(settings)),
//                 //     home: );
//               });
//         }),
//         error: ((error, stackTrace) => ErrorText(error: error.toString())),
//         loading: (() => const Loader()));
//   }
// }
