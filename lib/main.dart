import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/core/config/routes/app_routes.dart';
import 'package:flutter_note_app/core/config/theme/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/init/app_init.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      builder: (context, child) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final themeCubit = context.read<ThemeCubit>();
          
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!state.isLoadingTheme) {
              await themeCubit.loadTheme();
            }
          });
          
          return MaterialApp.router(
            theme: state.currentTheme,
            themeMode: state.themeMode,
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
