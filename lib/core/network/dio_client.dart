import 'package:dio/dio.dart';
import 'package:flutter_note_app/core/network/auth_interceptor.dart';
import 'package:flutter_note_app/core/init/di_container.dart';

/// Dio client configuration for API requests
/// Handles base URL, timeouts, and interceptors
class DioClient {
  static const String _baseUrl = 'https://note-app-backend-tau.vercel.app/api/v1';
  static const int _connectTimeout = 30000; // 30 seconds
  static const int _receiveTimeout = 30000; // 30 seconds
  static const int _sendTimeout = 30000; // 30 seconds

  late final Dio _dio;

  DioClient() {
    _dio = Dio();
    _setupDio();
  }

  /// Configure Dio instance with base settings and interceptors
  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(milliseconds: _connectTimeout),
      receiveTimeout: Duration(milliseconds: _receiveTimeout),
      sendTimeout: Duration(milliseconds: _sendTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add auth interceptor for JWT token management (from DI container)
    _dio.interceptors.add(getIt<AuthInterceptor>());
    
    // Add logging interceptor for debugging (only in debug mode)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
    ));
  }

  /// Get the configured Dio instance
  Dio get dio => _dio;
}
