import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter_note_app/presentation/profile/widget/profile_app_bar.dart';
import 'package:flutter_note_app/presentation/profile/widget/user_info.dart';
import 'package:flutter_note_app/presentation/profile/widget/language_selection.dart';
import 'package:flutter_note_app/presentation/profile/widget/theme_selection.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${StringConstants.profileError}${state.message}'),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileCubit>().loadUser(),
                    child: Text(StringConstants.profileRetryButton),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileSuccess) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // User Information
                  UserInfo(
                    email: state.user.email,
                    username: state.user.username ?? StringConstants.profileDefaultUsername,
                  ),

                  SizedBox(height: 10.h),

                  // Language Selection
                  const LanguageSelection(),

                  SizedBox(height: 10.h),

                  // Theme Selection
                  const ThemeSelection(),

                  SizedBox(height: 10.h),
                ],
              ),
            );
          }

          return Center(child: Text(StringConstants.profileUnknownState));
        },
      ),
    );
  }
}
