import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/layout/app_layout.dart';
import 'package:flutter_note_app/presentation/auth/view/login_view.dart';
import 'package:flutter_note_app/presentation/auth/view/signup_view.dart';
import 'package:flutter_note_app/presentation/note/pages/create_note_page.dart';
import 'package:go_router/go_router.dart';

final class AppRoutes {
  const AppRoutes._();
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String createNote = '/create-note';
  static GoRouter router = GoRouter(
    initialLocation: login,
    routes: <RouteBase>[
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) =>
             Container(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (BuildContext context, GoRouterState state) =>
            const AppLayout(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginView(),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (BuildContext context, GoRouterState state) =>
            const SignupView(),
      ),
      GoRoute(
        path: createNote,
        name: 'create-note',
        builder: (BuildContext context, GoRouterState state) =>
            const CreateNotePage(),
      ),
    ],
  );
}
