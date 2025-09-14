class ServerException implements Exception {
  ServerException(this.description);
  final String? description;
}

class CacheException implements Exception {
  CacheException(this.description);
  final String? description;
}

class ConnectionException implements Exception {
  ConnectionException(this.description);
  final String? description;
}

class UnKnownException implements Exception {
  UnKnownException(this.description);
  final String? description;
}

class AppVersionException implements Exception {
  AppVersionException(this.description);

  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}

class AuthException implements Exception {
  AuthException({
    required this.code,
    required this.message,
    this.statusCode,
  });

  final String code;
  final String message;
  final String? statusCode;

  @override
  String toString() {
    return 'AuthException(code: $code, message: $message, statusCode: $statusCode)';
  }
}
