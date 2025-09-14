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
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Get access token from secure storage
      final accessToken = await _authLocalDataSource.getAccessToken();
      
      if (accessToken != null && accessToken.isNotEmpty) {
        // Add Authorization header with Bearer token
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {
      // If token retrieval fails, continue without token
      // The request will likely fail with 401, which will be handled in onError
      print('⚠️ Failed to get access token: $e');
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized responses
    if (err.response?.statusCode == 401) {
      try {
        // Attempt to refresh the token
        final refreshed = await _refreshToken();
        
        if (refreshed) {
          // Get the new access token
          final newAccessToken = await _authLocalDataSource.getAccessToken();
          
          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            // Retry the original request with new token
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';
            
            try {
              final response = await Dio().fetch<Response<dynamic>>(options);
              handler.resolve(response);
              return;
            } catch (e) {
              // If retry fails, continue with original error
              print('⚠️ Request retry failed: $e');
            }
          }
        } else {
          // Refresh failed, logout user
          await _logoutUser();
        }
      } catch (e) {
        // If refresh process fails, logout user
        print('⚠️ Token refresh failed: $e');
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
        // Save new tokens to secure storage
        await _authLocalDataSource.saveTokens(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken ?? '',
        );
        
        print('🟢 Token refreshed successfully');
        return true;
      }
      
      return false;
    } catch (e) {
      print('🔴 Token refresh failed: $e');
      return false;
    }
  }

  /// Logout user and clear tokens
  Future<void> _logoutUser() async {
    try {
      // Clear tokens from secure storage
      await _authLocalDataSource.clearTokens();
      
      // Sign out from Supabase
      await _supabase.auth.signOut();
      
      print('🔴 User logged out due to token refresh failure');
      
      // TODO: Navigate to login screen or trigger logout event
      // This could be handled by a global state management solution
    } catch (e) {
      print('⚠️ Logout failed: $e');
    }
  }
}
