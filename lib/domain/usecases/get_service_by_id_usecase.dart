import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service_entity.dart';
import '../repository/service_repository.dart';

/// Use case: Fetch details of a single service by ID.
class GetServiceByIdUseCase {
  const GetServiceByIdUseCase(this._repository);

  final ServiceRepository _repository;

  Future<Either<Failure, ServiceEntity>> call(String id) {
    return _repository.getServiceById(id);
  }
}
