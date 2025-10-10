import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/pallete.dart';

// import 'theme.dart';

class LocalSettings {
  static SharedPreferences? globalSharedPref;

  static Future<void> getTheme() async {
    String themeName = (globalSharedPref!.getString("theme")) ?? "System";
    if (themeName == "System") {
      ThemeNotifier.globalThemeMode.value = ThemeMode.system;
    } else if (themeName == "Dark") {
      ThemeNotifier.globalThemeMode.value = ThemeMode.dark;
    } else {
      ThemeNotifier.globalThemeMode.value = ThemeMode.light;
    }
  }
}
