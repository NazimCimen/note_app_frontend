import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
import 'package:flutter_note_app/domain/usecases/profile/get_user_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUseCase getUserUseCase;

  ProfileCubit({
    required this.getUserUseCase,
  }) : super(const ProfileInitial());

  Future<void> loadUser() async {
    emit(const ProfileLoading());
    
    final result = await getUserUseCase();
    
    result.fold(
      (failure) => emit(ProfileFailure(failure.errorMessage)),
      (user) => emit(ProfileSuccess(user ?? UserEntity(
        id: 'unknown',
        email: 'unknown@example.com',
        username: 'Kullanıcı',
        createdAt: DateTime.now(),
      ))),
    );
  }
}
