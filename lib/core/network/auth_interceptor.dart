import 'package:dio/dio.dart';
import 'package:flutter_note_app/data/datasources/local/auth_local_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Interceptor for handling JWT authentication
/// Automatically adds access token to requests and handles token refresh
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _authLocalDataSource;
  final SupabaseClient _supabase;

  AuthInterceptor({
    AuthLocalDataSource? authLocalDataSource,
    SupabaseClient? supabase,
  }) : _authLocalDataSource = authLocalDataSource ?? AuthLocalDataSource(),
       _supabase = supabase ?? Supabase.instance.client;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await _authLocalDataSource.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {}

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshed = await _refreshToken();

        if (refreshed) {
          final newAccessToken = await _authLocalDataSource.getAccessToken();

          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';

            try {
              final response = await Dio().fetch<Response<dynamic>>(options);
              handler.resolve(response);
              return;
            } catch (e) {}
          }
        } else {
          await _logoutUser();
        }
      } catch (e) {
        await _logoutUser();
      }
    }

    handler.next(err);
  }

  /// Refresh the access token using Supabase
  Future<bool> _refreshToken() async {
    try {
      final response = await _supabase.auth.refreshSession();
      if (response.session?.accessToken != null) {
        await _authLocalDataSource.saveTokens(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken ?? '',
        );
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Logout user and clear tokens
  Future<void> _logoutUser() async {
    try {
      await _authLocalDataSource.clearTokens();
      await _supabase.auth.signOut();
    } catch (e) {}
  }
}
