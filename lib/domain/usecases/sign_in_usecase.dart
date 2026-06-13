import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

/// Use case: Authenticate the user with username and password.
///
/// Usage (in Cubit):
///   final result = await _signInUseCase(username: 'user', password: 'pass');
///   result.fold(
///     (failure) => emit(SignInError(failure.message)),
///     (user)    => emit(SignInSuccess(user)),
///   );
class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call({
    required String username,
    required String password,
  }) {
    return _repository.signIn(username: username, password: password);
  }
}
