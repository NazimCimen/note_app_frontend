import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/presentation/layout/bottom_nav.dart';
import 'package:flutter_note_app/presentation/profile/profile_view.dart';
import 'package:flutter_note_app/presentation/home/view/home_view.dart';
import 'package:flutter_note_app/presentation/layout/cubit/app_layout_cubit.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';
import 'package:flutter_note_app/core/init/di_container.dart';

/// Main application layout with bottom navigation
/// Handles navigation between different sections of the app
class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppLayoutCubit()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
      ],
      child: const _AppLayoutView(),
    );
  }
}

class _AppLayoutView extends StatelessWidget {
  const _AppLayoutView();

  static const List<Widget> _pages = [HomeView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutCubit, AppLayoutState>(
      builder: (context, state) {
        final currentIndex = state is AppLayoutTabChanged
            ? state.currentIndex
            : 0;
        return Scaffold(
          body: IndexedStack(index: currentIndex, children: _pages),

          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: currentIndex,
            onNavTap: (index) {
              context.read<AppLayoutCubit>().changeTab(index);
            },
          ),
        );
      },
    );
  }
}
