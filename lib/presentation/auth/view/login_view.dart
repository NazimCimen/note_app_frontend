import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/shared/widgets/custom_button.dart';
import 'package:flutter_note_app/shared/components/custom_snack_bar.dart';
import 'package:flutter_note_app/core/config/routes/app_routes.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/core/utils/app_validators.dart';
import 'package:flutter_note_app/core/utils/enum/image_enum.dart';
import 'package:flutter_note_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_note_app/presentation/auth/mixin/login_mixin.dart';
import 'package:flutter_note_app/presentation/auth/widgets/auth_loading_widget.dart';
import 'package:flutter_note_app/presentation/auth/widgets/footer.dart';
import 'package:flutter_note_app/presentation/auth/widgets/header.dart';
import 'package:flutter_note_app/presentation/auth/widgets/custom_password_text_field.dart';
import 'package:flutter_note_app/presentation/auth/widgets/custom_text_form_field.dart';
import 'package:flutter_note_app/core/init/di_container.dart';
import 'package:flutter_note_app/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_note_app/domain/usecases/auth/signup_usecase.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: getIt<LoginUseCase>(),
        signupUseCase: getIt<SignupUseCase>(),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            CustomSnackBar.showError(context, state.message);
          }
          if (state is AuthSuccess) {
            CustomSnackBar.showSuccess(context, 'Giriş başarılı');
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AuthLoading || state is AuthSocialLoading,
            child: Scaffold(
              backgroundColor: AppColors.background,
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: state is AuthSocialLoading
                    ? const AuthLoadingWidget()
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                              left: 24.w,
                              right: 24.w,
                              top: 32.h,
                              bottom: MediaQuery.of(context).viewInsets.bottom + 32.h,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Login title
                                    Header(
                                      title: StringConstants.authLoginTitle,
                                      subtitle: StringConstants.authLoginSubtitle,
                                    ),
                                    SizedBox(height: 48.h),
                                    
                                    // Email input field
                                    CustomTextFormField(
                                      controller: emailController,
                                      validator: (value) =>
                                          AppValidators.emailValidator(value),
                                      hintText: StringConstants.email,
                                      prefixIconPath:
                                          ImageEnums.ic_email.toPathPng,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                    ),

                                    SizedBox(height: 16.h),

                                    // Password input field
                                    ValueListenableBuilder<bool>(
                                      valueListenable: obscureListenable,
                                      builder: (context, isObscure, _) {
                                        return CustomPasswordTextField(
                                          controller: passwordController,
                                          hintText: StringConstants.password,
                                          obsecureText: isObscure,
                                          changeObsecureText: changeObsecureText,
                                        );
                                      },
                                    ),

                                    SizedBox(height: 24.h),
                                    
                                    // Login button
                                    CustomButtonWidget(
                                      onPressed: () => login(context),
                                      text: StringConstants.login,
                                      isRequestAvaliable: state is AuthLoading,
                                    ),

                                    SizedBox(height: 48.h),

                                    // Sign up link
                                    Footer(
                                      text: StringConstants.dontHaveAccount,
                                      linkText: StringConstants.goToSignup,
                                      onTap: () {
                                        context.go(AppRoutes.signup);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
