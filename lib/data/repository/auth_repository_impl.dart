import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../models/user_model.dart';

/// Concrete implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDatasource,
  });

  final AuthRemoteDatasource remoteDatasource;
  final _log = appLogger(AuthRepositoryImpl);

  // ── signIn ────────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final model = await remoteDatasource.signIn(
        username: username,
        password: password,
      );
      // Persist auth token and user data locally.
      await LocalStorage.saveToken(token: model.token);
      await LocalStorage.saveUserJson(json: json.encode(model.toJson()));
      _log.i('signIn success: ${model.email}');
      return Right(model.toEntity());
    } on AuthException catch (e) {
      _log.e('Auth error: ${e.message}');
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      _log.e('Server error: ${e.message}');
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      _log.e('Unexpected sign-in error: $e');
      return const Left(UnexpectedFailure());
    }
  }

  // ── signOut ───────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await remoteDatasource.signOut();
      await LocalStorage.clearAll();
      _log.i('signOut success');
      return const Right(true);
    } catch (e) {
      _log.e('signOut error: $e');
      return const Left(UnexpectedFailure());
    }
  }

  // ── getCachedUser ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() async {
    try {
      final userJson = LocalStorage.getUserJson();
      if (userJson == null || userJson.isEmpty) {
        return const Right(null);
      }
      final model =
          UserModel.fromJson(json.decode(userJson) as Map<String, dynamic>);
      return Right(model.toEntity());
    } catch (e) {
      _log.e('getCachedUser error: $e');
      return const Left(CacheFailure());
    }
  }
}
