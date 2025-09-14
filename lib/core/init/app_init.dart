import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_note_app/core/config/localization/locale_constants.dart';
import 'package:flutter_note_app/core/config/theme/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/main.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_note_app/core/init/di_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppInit {
  Future<void> initialize();
  Future<void> run();
  Widget getApp();
}

class AppInitImpl extends AppInit {
  @override
  Widget getApp() {
    return EasyLocalization(
      supportedLocales: const [
        LocaleConstants.enLocale,
        LocaleConstants.trLocale,
        LocaleConstants.ptLocale,
        LocaleConstants.jaLocale,
        LocaleConstants.krLocale,
        LocaleConstants.cnLocale,
        LocaleConstants.ruLocale,
        LocaleConstants.frLocale,
        LocaleConstants.deLocale,
        LocaleConstants.itLocale,
        LocaleConstants.esLocale,
        LocaleConstants.saLocale,
      ],
      path: LocaleConstants.localePath,
      fallbackLocale: LocaleConstants.enLocale,

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeManager>(
            create: (context) => ThemeManager(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }

  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await EasyLocalization.ensureInitialized();

    await Hive.initFlutter();

    await dotenv.load(fileName: '.env');

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_KEY']!,
    );
    setupDI();
  }

  @override
  Future<void> run() async {
    await initialize();
    runApp(getApp());
  }
}
