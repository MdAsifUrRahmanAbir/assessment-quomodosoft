import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service_entity.dart';
import '../repository/service_repository.dart';

/// Use case: Create a new service.
class CreateServiceUseCase {
  const CreateServiceUseCase(this._repository);

  final ServiceRepository _repository;

  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) {
    return _repository.createService(service);
  }
}
