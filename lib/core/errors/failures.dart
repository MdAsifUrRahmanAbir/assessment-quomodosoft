import 'package:equatable/equatable.dart';

/// Base failure class — all domain-level errors extend this.
///
/// Used with dartz [Either] as the Left type:
///   `Either<Failure, T>`
abstract class Failure extends Equatable {
  const Failure([this.message = '']);

  final String message;

  @override
  List<Object> get props => [message];
}

// ── Concrete failures ────────────────────────────────────────────────────────

/// Remote API returned an error (4xx / 5xx).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred.']);
}

/// No network connection.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

/// Local cache read/write failed.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred.']);
}

/// Auth failure (invalid credentials, token expired, etc.).
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed.']);
}

/// Generic unexpected failure.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred.']);
}
