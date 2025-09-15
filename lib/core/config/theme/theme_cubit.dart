import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/config/theme/application_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeEnum { dark, light }

abstract class IThemeManager {
  Future<void> changeTheme(ThemeEnum theme);
  Future<void> loadTheme();
}

class ThemeState {
  final ThemeData currentTheme;
  final ThemeEnum currentThemeEnum;
  final ThemeMode themeMode;
  final bool isLoadingTheme;

  const ThemeState({
    required this.currentTheme,
    required this.currentThemeEnum,
    required this.themeMode,
    this.isLoadingTheme = false,
  });

  ThemeState copyWith({
    ThemeData? currentTheme,
    ThemeEnum? currentThemeEnum,
    ThemeMode? themeMode,
    bool? isLoadingTheme,
  }) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
      currentThemeEnum: currentThemeEnum ?? this.currentThemeEnum,
      themeMode: themeMode ?? this.themeMode,
      isLoadingTheme: isLoadingTheme ?? this.isLoadingTheme,
    );
  }
}

class ThemeCubit extends Cubit<ThemeState> implements IThemeManager {
  static const String _themeKey = 'theme';

  ThemeCubit() : super(ThemeState(
    currentTheme: CustomLightTheme().themeData,
    currentThemeEnum: ThemeEnum.light,
    themeMode: ThemeMode.light,
  ));

  /// IT USED TO CHANGE APP THEME LIGHT OR DARK.
  @override
  Future<void> changeTheme(ThemeEnum theme) async {
    emit(state.copyWith(isLoadingTheme: true));
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, theme.name);
      
      final newTheme = theme == ThemeEnum.dark
          ? CustomDarkTheme().themeData
          : CustomLightTheme().themeData;
      
      emit(state.copyWith(
        currentTheme: newTheme,
        currentThemeEnum: theme,
        themeMode: theme == ThemeEnum.dark ? ThemeMode.dark : ThemeMode.light,
        isLoadingTheme: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoadingTheme: false));
      rethrow;
    }
  }

  /// IT USED TO LOAD APP THEME WHEN APP LAUNCH.
  @override
  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeName = prefs.getString(_themeKey);
      
      if (themeName != null) {
        final themeEnum = ThemeEnum.values.firstWhere((e) => e.name == themeName);
        final newTheme = themeEnum == ThemeEnum.dark
            ? CustomDarkTheme().themeData
            : CustomLightTheme().themeData;
        
        emit(state.copyWith(
          currentTheme: newTheme,
          currentThemeEnum: themeEnum,
          themeMode: themeEnum == ThemeEnum.dark ? ThemeMode.dark : ThemeMode.light,
        ));
      }
    } catch (e) {
      // Keep default theme if loading fails
    }
  }
}
