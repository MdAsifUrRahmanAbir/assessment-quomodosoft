import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Abstract contract for authentication operations.
///
/// Implemented by [AuthRepositoryImpl] in the data layer.
abstract class AuthRepository {
  /// Signs in with [username] and [password].
  /// Returns the authenticated [UserEntity] or a [Failure].
  Future<Either<Failure, UserEntity>> signIn({
    required String username,
    required String password,
  });

  /// Signs out the current user (clears local token).
  Future<Either<Failure, bool>> signOut();

  /// Returns the currently cached user, if any.
  Future<Either<Failure, UserEntity?>> getCachedUser();
}
