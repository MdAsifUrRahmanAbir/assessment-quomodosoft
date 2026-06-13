import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service_entity.dart';
import '../repository/service_repository.dart';

/// Use case: Update an existing service.
class UpdateServiceUseCase {
  const UpdateServiceUseCase(this._repository);

  final ServiceRepository _repository;

  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) {
    return _repository.updateService(service);
  }
}
