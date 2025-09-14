import 'package:flutter_note_app/core/config/theme/application_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IThemeManager {
  late ThemeData currentTheme;
  late ThemeEnum currentThemeEnum;
  late ThemeMode themeMode;
  bool isLoadingTheme = false;
  Future<void> changeTheme(ThemeEnum theme);
  Future<void> loadTheme();
}

enum ThemeEnum { dark, light }

class ThemeManager extends ChangeNotifier implements IThemeManager {
  static const String _themeKey = 'theme';

  @override
  ThemeData currentTheme = CustomLightTheme().themeData;

  @override
  ThemeEnum currentThemeEnum = ThemeEnum.light;

  @override
  ThemeMode themeMode = ThemeMode.light;

  @override
  bool isLoadingTheme = false;

  ThemeManager() {
    // Theme will be loaded after ScreenUtil initialization
  }

  void isLoading(bool value) {
    isLoadingTheme = value;
    notifyListeners();
  }

  /// IT USED TO CHANGE APP THEME LIGHT OR DARK.
  @override
  Future<void> changeTheme(ThemeEnum theme) async {
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.name);
    currentThemeEnum = theme;
    currentTheme = theme == ThemeEnum.dark
        ? CustomDarkTheme().themeData
        : CustomLightTheme().themeData;
    themeMode = theme == ThemeEnum.dark ? ThemeMode.dark : ThemeMode.light;
    isLoading(false);
  }

  /// IT USED TO LOAD APP THEME WHEN APP LAUNCH.
  @override
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey);
    if (themeName != null) {
      currentThemeEnum =
          ThemeEnum.values.firstWhere((e) => e.name == themeName);
      currentTheme = currentThemeEnum == ThemeEnum.dark
          ? CustomDarkTheme().themeData
          : CustomLightTheme().themeData;
      themeMode =
          currentThemeEnum == ThemeEnum.dark ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }
}
