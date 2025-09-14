/// Simple authentication utility functions
class AuthUtils {
  // Basit JWT token storage için static variable
  static String? _currentJwtToken;

  /// Set JWT token manually for testing
  static void setJwtToken(String token) {
    _currentJwtToken = token;
    print('🟢 JWT Token set edildi: ${token.substring(0, 20)}...');
  }

  /// Clear JWT token
  static void clearJwtToken() {
    _currentJwtToken = null;
    print('🔴 JWT Token temizlendi');
  }

  /// Get current token
  static String? getCurrentToken() {
    return _currentJwtToken;
  }

  /// Check if token is set
  static bool isTokenSet() {
    return _currentJwtToken != null && _currentJwtToken!.isNotEmpty;
  }

  /// Set test token for development
  static void setTestToken() {
    const testToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
    setJwtToken(testToken);
    print('🧪 Test token set edildi');
  }
}
