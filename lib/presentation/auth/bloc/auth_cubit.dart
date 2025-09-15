import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/utils/params/login_params.dart';
import 'package:flutter_note_app/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_note_app/domain/usecases/auth/signup_usecase.dart';
import 'package:flutter_note_app/domain/usecases/auth/check_auth_use_case.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.checkAuthUseCase,
  }) : super(const AuthState.initial());

  Future<void> login({required String email, required String password}) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());

    final params = AuthParams(email: email, password: password);
    final result = await loginUseCase(params);

    result.fold(
      (failure) => emit(AuthState.failure(failure.errorMessage)),
      (_) => emit(const AuthState.success()),
    );
  }

  Future<void> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());

    final params = AuthParams(
      fullName: fullName,
      email: email,
      password: password,
    );

    final result = await signupUseCase(params);

    result.fold((failure) {
      if (failure.errorMessage == '23505') {
        emit(const AuthState.failure('Bu e-posta adresi zaten kullanılıyor.'));
      } else {
        emit(AuthState.failure(failure.errorMessage));
      }
    }, (_) => emit(const AuthState.success()));
  }

  Future<bool> checkAuth() async {
    final result = await checkAuthUseCase();
    return result.fold(
      (failure) => false,
      (isAuthenticated) => isAuthenticated,
    );
  }
}
