import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

// Domain layer
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';
import 'package:flutter_note_app/domain/repositories/user_repository.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:flutter_note_app/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_note_app/domain/usecases/auth/signup_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/create_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/get_notes_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/toggle_favorite_usecase.dart';

// Data layer
import 'package:flutter_note_app/data/repositories/auth_repository_impl.dart';
import 'package:flutter_note_app/data/repositories/user_repository_impl.dart';
import 'package:flutter_note_app/data/repositories/note_repository_impl.dart';
import 'package:flutter_note_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flutter_note_app/data/datasources/remote/user_service.dart';
import 'package:flutter_note_app/data/datasources/remote/note_remote_data_source.dart';
import 'package:flutter_note_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter_note_app/core/network/dio_client.dart';
import 'package:flutter_note_app/core/network/auth_interceptor.dart';

// Presentation layer
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  // External dependencies
  getIt
 
    ..registerLazySingleton<SupabaseClient>(() => Supabase.instance.client)
    ..registerLazySingleton<DioClient>(() => DioClient())
    ..registerLazySingleton<Dio>(() => getIt<DioClient>().dio);

  // Data layer - Data Sources
  getIt
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Core layer - Network
  getIt
    ..registerLazySingleton<AuthInterceptor>(() => AuthInterceptor());

  // Data layer - Services
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabase: getIt<SupabaseClient>(),
        authLocalDataSource: getIt<AuthLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<UserService>(() => UserServiceImpl())
    ..registerLazySingleton<NoteRemoteDataSource>(
      () => NoteRemoteDataSourceImpl(
        dio: getIt<Dio>(), 
      ),
    );

  // Data layer - Repositories
  getIt
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        service: getIt<AuthRemoteDataSource>(),
        authLocalDataSource: getIt<AuthLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userService: getIt<UserService>()),
    )
    ..registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(noteService: getIt<NoteRemoteDataSource>()),
    );

  // Domain layer - Use cases
  getIt
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(getIt<AuthRepository>(), getIt<UserRepository>()),
    )
 
    ..registerLazySingleton<CreateNoteUseCase>(
      () => CreateNoteUseCase(getIt<NoteRepository>()),
    )
    ..registerLazySingleton<GetNotesUseCase>(
      () => GetNotesUseCase(noteRepository: getIt<NoteRepository>()),
    )
    ..registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(noteRepository: getIt<NoteRepository>()),
    );

  // Presentation layer - Cubits
  getIt
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        getNotesUseCase: getIt<GetNotesUseCase>(),
        toggleFavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
      ),
    );
}
