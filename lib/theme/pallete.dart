import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromARGB(255, 80, 98, 106); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Color.fromARGB(255, 164, 214, 255);
  static var yellowColor = Color.fromARGB(255, 255, 221, 3);
  static var greenColor = Color.fromARGB(255, 108, 162, 79);
  static var green =  Color(0xFF00AF19);

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    colorScheme: ColorScheme(
      brightness: ThemeNotifier.globalThemeBrightness,
      primary: redColor,
      onPrimary: blueColor,
      secondary: greenColor,
      onSecondary: greyColor,
      error: redColor,
      onError: Colors.black45,
      surface: blueColor,
      onSurface: blackColor,
    ), // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor, 
    colorScheme: ColorScheme(
      brightness: ThemeNotifier.globalThemeBrightness,
      primary: redColor,
      onPrimary: blueColor,
      secondary: greenColor,
      onSecondary: greyColor,
      error: redColor,
      onError: Colors.black45,
      surface: blueColor,
      onSurface: blackColor,

      ),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  static ValueNotifier<ThemeMode> globalThemeMode = ValueNotifier<ThemeMode>(ThemeMode.system);
  static Brightness globalThemeBrightness = globalThemeMode.value == ThemeMode.system
      ? SchedulerBinding.instance.window.platformBrightness
      : globalThemeMode.value == ThemeMode.dark
          ? Brightness.dark
          : Brightness.light;

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
