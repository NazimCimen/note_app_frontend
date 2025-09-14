import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

/// Centralized Dio error handler
/// Handles all DioException types and returns appropriate Failure objects
class DioErrorHandler {
  static Either<Failure, T> handleDioError<T>(DioException e) {

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return left(ConnectionFailure(errorMessage: StringConstants.dioConnectionTimeout));
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(e);
        
      case DioExceptionType.cancel:
        return left(ServerFailure(errorMessage: StringConstants.dioRequestCancelled));
        
      case DioExceptionType.connectionError:
        return left(
          ConnectionFailure(
            errorMessage: '${StringConstants.dioConnectionError}.\n'
                'Sunucunun çalıştığından emin olun: ${e.requestOptions.uri.host}:${e.requestOptions.uri.port}',
          ),
        );
        
      default:
        return left(
          ServerFailure(errorMessage: '${StringConstants.dioUnknownError}: ${e.message}'),
        );
    }
  }

  /// Handle bad response errors (4xx, 5xx)
  static Either<Failure, T> _handleBadResponse<T>(DioException e) {
    final statusCode = e.response?.statusCode;
    
    switch (statusCode) {
      case 400:
        return left(ServerFailure(errorMessage: StringConstants.httpBadRequest));
      case 401:
        return left(AuthFailure(errorMessage: StringConstants.dioAuthError));
      case 403:
        return left(AuthFailure(errorMessage: StringConstants.httpForbidden));
      case 404:
        return left(ServerFailure(errorMessage: StringConstants.dioNotFound));
      case 409:
        return left(ServerFailure(errorMessage: StringConstants.httpConflict));
      case 422:
        return left(ServerFailure(errorMessage: StringConstants.httpUnprocessableEntity));
      case 429:
        return left(ServerFailure(errorMessage: StringConstants.httpTooManyRequests));
      case 500:
        return left(ServerFailure(errorMessage: StringConstants.dioServerError));
      case 502:
        return left(ServerFailure(errorMessage: StringConstants.httpBadGateway));
      case 503:
        return left(ServerFailure(errorMessage: StringConstants.httpServiceUnavailable));
      case 504:
        return left(ServerFailure(errorMessage: StringConstants.httpGatewayTimeout));
      default:
        return left(
          ServerFailure(errorMessage: 'HTTP ${statusCode}: ${e.message}'),
        );
    }
  }

  /// Handle unexpected errors
  static Either<Failure, T> handleUnexpectedError<T>(dynamic error) {
    return left(
      ServerFailure(errorMessage: '${StringConstants.dioUnexpectedError}: ${error.toString()}'),
    );
  }
}
