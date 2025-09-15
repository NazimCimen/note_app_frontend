// lib/presentation/splash/view/splash_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/config/routes/app_routes.dart';
import 'package:flutter_note_app/core/init/di_container.dart';
import 'package:flutter_note_app/core/utils/enum/image_enum.dart';
import 'package:flutter_note_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2), () {});
      final isAuthenticated = await context.read<AuthCubit>().checkAuth();
      if (isAuthenticated && mounted) {
        context.go(AppRoutes.home);
      } else {
        if (mounted) {
          context.go(AppRoutes.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(child: Image.asset(ImageEnums.logo.toPathPng)),
      ),
    );
  }
}
