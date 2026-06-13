/// Thrown when a remote API call fails (4xx / 5xx status codes).
class ServerException implements Exception {
  const ServerException([this.message = 'Server error occurred.']);
  final String message;

  @override
  String toString() => 'ServerException: $message';
}

/// Thrown when there is no network connectivity.
class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection.']);
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when a local cache read/write operation fails.
class CacheException implements Exception {
  const CacheException([this.message = 'Cache operation failed.']);
  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown when authentication fails (401 / invalid credentials).
class AuthException implements Exception {
  const AuthException([this.message = 'Authentication failed.']);
  final String message;

  @override
  String toString() => 'AuthException: $message';
}
