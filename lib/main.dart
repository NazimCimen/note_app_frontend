import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/core/config/routes/app_routes.dart';
import 'package:flutter_note_app/core/config/theme/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/init/app_init.dart';
import 'package:provider/provider.dart';

void main() async {
  final appInit = AppInitImpl();
  await appInit.run();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) async{
            if (!themeManager.isLoadingTheme) {
              await themeManager.loadTheme();
            }
          });         
          return MaterialApp.router(
            theme: themeManager.currentTheme,
            themeMode: themeManager.themeMode,
            title: StringConstants.appName,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}
