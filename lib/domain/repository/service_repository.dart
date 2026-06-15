import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../entities/service_entity.dart';

/// Abstract contract for all service-related data operations.
///
/// Implemented by [ServiceRepositoryImpl] in the data layer.
/// Consumed by use cases in the domain layer.
abstract class ServiceRepository {
  /// Returns a list of all services for the authenticated user.
  Future<Either<Failure, List<ServiceEntity>>> getServices({int page = 1});

  /// Returns a single service by [id].
  Future<Either<Failure, ServiceEntity>> getServiceById(String id);

  /// Creates a new service and returns the created entity.
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);

  /// Updates an existing service and returns the updated entity.
  Future<Either<Failure, ServiceEntity>> updateService(ServiceEntity service);

  /// Deletes the service with [id]. Returns true on success.
  Future<Either<Failure, bool>> deleteService(String id);

  /// Returns a list of all active service categories.
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
