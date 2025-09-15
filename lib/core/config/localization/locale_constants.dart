import 'dart:ui';
import 'package:flutter_note_app/core/config/localization/app_languages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_note_app/core/utils/enum/image_enum.dart';

@immutable
final class LocaleConstants {
  const LocaleConstants._();
  static const trLocale = Locale('tr', 'TR');
  static const enLocale = Locale('en', 'US');
  static const ptLocale = Locale('pt', 'BR');
  static const jaLocale = Locale('ja', 'JP');
  static const krLocale = Locale('ko', 'KR');
  static const cnLocale = Locale('zh', 'CN');
  static const ruLocale = Locale('ru', 'RU');
  static const frLocale = Locale('fr', 'FR');
  static const deLocale = Locale('de', 'DE');
  static const itLocale = Locale('it', 'IT');
  static const esLocale = Locale('es', 'ES');
  static const saLocale = Locale('ar', 'SA');
  static const localePath = 'assets/lang';

  static final List<AppLanguages> languageList = [
    AppLanguages(
      name: 'Türkçe',
      locale: trLocale,
      flagName: ImageEnums.flag_turkiye.toPathPng,
    ),
    AppLanguages(
      name: 'English',
      locale: enLocale,
      flagName: ImageEnums.flag_usa.toPathPng,
    ),
  
  ];
}
