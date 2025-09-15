import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

// Domain layer
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';
import 'package:flutter_note_app/domain/repositories/user_repository.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:flutter_note_app/domain/repositories/profile_repository.dart';
import 'package:flutter_note_app/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_note_app/domain/usecases/auth/signup_usecase.dart';
import 'package:flutter_note_app/domain/usecases/auth/check_auth_use_case.dart';
import 'package:flutter_note_app/domain/usecases/note/create_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/update_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/get_notes_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/toggle_favorite_usecase.dart';
import 'package:flutter_note_app/domain/usecases/profile/get_user_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/generate_keywords_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/generate_summary_usecase.dart';

// Data layer
import 'package:flutter_note_app/data/repositories/auth_repository_impl.dart';
import 'package:flutter_note_app/data/repositories/user_repository_impl.dart';
import 'package:flutter_note_app/data/repositories/note_repository_impl.dart';
import 'package:flutter_note_app/data/repositories/profile_repository_impl.dart';
import 'package:flutter_note_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flutter_note_app/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flutter_note_app/data/datasources/remote/note_remote_data_source.dart';
import 'package:flutter_note_app/data/datasources/remote/gemini_service.dart';
import 'package:flutter_note_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter_note_app/core/network/dio_client.dart';
import 'package:flutter_note_app/core/network/auth_interceptor.dart';

// Presentation layer
import 'package:flutter_note_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';
import 'package:flutter_note_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter_note_app/presentation/note/bloc/create_note_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  // External dependencies
  getIt
    ..registerLazySingleton<SupabaseClient>(() => Supabase.instance.client)
    ..registerLazySingleton<DioClient>(() => DioClient())
    ..registerLazySingleton<Dio>(() => getIt<DioClient>().dio)
    ..registerLazySingleton<Dio>(() => getIt<DioClient>().geminiDio, instanceName: 'gemini');

  // Data layer - Data Sources
  getIt
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Core layer - Network
  getIt..registerLazySingleton<AuthInterceptor>(() => AuthInterceptor());

  // Data layer - Services
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabase: getIt<SupabaseClient>(),
        authLocalDataSource: getIt<AuthLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    )
    ..registerLazySingleton<GeminiService>(
      () => GeminiServiceImpl(dio: getIt<Dio>(instanceName: 'gemini')),
    )
    ..registerLazySingleton<NoteRemoteDataSource>(
      () => NoteRemoteDataSourceImpl(dio: getIt<Dio>()),
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
      () => UserRepositoryImpl(userService: getIt<ProfileRemoteDataSource>()),
    )
    ..registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(
        noteService: getIt<NoteRemoteDataSource>(),
        geminiService: getIt<GeminiService>(),
      ),
    )
    ..registerLazySingleton<ProfileRepository>(
      () =>
          ProfileRepositoryImpl(userService: getIt<ProfileRemoteDataSource>()),
    );

  // Domain layer - Use cases
  getIt
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(getIt<AuthRepository>(), getIt<UserRepository>()),
    )
    ..registerLazySingleton<CheckAuthUseCase>(
      () => CheckAuthUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<CreateNoteUseCase>(
      () => CreateNoteUseCase(getIt<NoteRepository>()),
    )
    ..registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(getIt<NoteRepository>()),
    )
    ..registerLazySingleton<GetNotesUseCase>(
      () => GetNotesUseCase(noteRepository: getIt<NoteRepository>()),
    )
    ..registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(noteRepository: getIt<NoteRepository>()),
    )
    ..registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(repository: getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<GenerateKeywordsUseCase>(
      () => GenerateKeywordsUseCase(getIt<NoteRepository>()),
    )
    ..registerLazySingleton<GenerateSummaryUseCase>(
      () => GenerateSummaryUseCase(getIt<NoteRepository>()),
    );

  // Presentation layer - Cubits

  getIt
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        loginUseCase: getIt<LoginUseCase>(),
        signupUseCase: getIt<SignupUseCase>(),
        checkAuthUseCase: getIt<CheckAuthUseCase>(),
      ),
    )
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        getNotesUseCase: getIt<GetNotesUseCase>(),
        toggleFavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
      ),
    )
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(getUserUseCase: getIt<GetUserUseCase>()),
    )
    ..registerFactory<CreateNoteCubit>(
      () => CreateNoteCubit(
        createNoteUseCase: getIt<CreateNoteUseCase>(),
        updateNoteUseCase: getIt<UpdateNoteUseCase>(),
        generateKeywordsUseCase: getIt<GenerateKeywordsUseCase>(),
        generateSummaryUseCase: getIt<GenerateSummaryUseCase>(),
      ),
    );
}
