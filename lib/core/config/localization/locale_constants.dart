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
    AppLanguages(
      name: 'العربية',
      locale: saLocale,
      flagName: ImageEnums.flag_saudi_arabia.toPathPng,
    ),
    AppLanguages(
      name: 'Português',
      locale: ptLocale,
      flagName: ImageEnums.flag_brazil.toPathPng,
    ),
    AppLanguages(
      name: '日本語',
      locale: jaLocale,
      flagName: ImageEnums.flag_japan.toPathPng,
    ),
    AppLanguages(
      name: '한국어',
      locale: krLocale,
      flagName: ImageEnums.flag_south_korea.toPathPng,
    ),
    AppLanguages(
      name: '中文',
      locale: cnLocale,
      flagName: ImageEnums.flag_china.toPathPng,
    ),
    AppLanguages(
      name: 'Русский',
      locale: ruLocale,
      flagName: ImageEnums.flag_russia.toPathPng,
    ),
    AppLanguages(
      name: 'Français',
      locale: frLocale,
      flagName: ImageEnums.flag_france.toPathPng,
    ),
    AppLanguages(
      name: 'Deutsch',
      locale: deLocale,
      flagName: ImageEnums.flag_germany.toPathPng,
    ),
    AppLanguages(
      name: 'Italiano',
      locale: itLocale,
      flagName: ImageEnums.flag_italy.toPathPng,
    ),
    AppLanguages(
      name: 'Español',
      locale: esLocale,
      flagName: ImageEnums.flag_spain.toPathPng,
    ),
  ];
}
