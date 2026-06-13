import 'package:dartz/dartz.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/app_logger.dart';
import '../../../domain/entities/service_entity.dart';
import '../../../domain/repository/service_repository.dart';
import '../datasource/remote/service_remote_datasource.dart';
import '../models/service_model.dart';

/// Concrete implementation of [ServiceRepository].
///
/// Simplified to call remote only, without any local cache fallback.
class ServiceRepositoryImpl implements ServiceRepository {
  ServiceRepositoryImpl({
    required this.remoteDatasource,
  });

  final ServiceRemoteDatasource remoteDatasource;
  final _log = appLogger(ServiceRepositoryImpl);

  // ── getServices ───────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices() async {
    try {
      final models = await remoteDatasource.getServices();
      final entities = models.map((m) => m.toEntity()).toList();
      _log.i('Fetched ${entities.length} services from remote.');
      return Right(entities);
    } on ServerException catch (e) {
      _log.e('Server error: ${e.message}');
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      _log.e('Unexpected error: $e');
      return const Left(UnexpectedFailure());
    }
  }

  // ── getServiceById ────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ServiceEntity>> getServiceById(String id) async {
    try {
      final model = await remoteDatasource.getServiceById(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  // ── createService ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ServiceEntity>> createService(
      ServiceEntity service) async {
    try {
      final model = await remoteDatasource.createService(
        ServiceModel.fromEntity(service),
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  // ── updateService ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ServiceEntity>> updateService(
      ServiceEntity service) async {
    try {
      final model = await remoteDatasource.updateService(
        ServiceModel.fromEntity(service),
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  // ── deleteService ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, bool>> deleteService(String id) async {
    try {
      final success = await remoteDatasource.deleteService(id);
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }
}
