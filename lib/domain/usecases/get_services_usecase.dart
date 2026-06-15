import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service_entity.dart';
import '../repository/service_repository.dart';

/// Use case: Fetch all services for the authenticated user.
///
/// Usage (in Cubit):
///   final result = await _getServicesUseCase();
///   result.fold(
///     (failure) => emit(ServiceError(failure.message)),
///     (services) => emit(ServiceLoaded(services)),
///   );
class GetServicesUseCase {
  const GetServicesUseCase(this._repository);

  final ServiceRepository _repository;

  Future<Either<Failure, List<ServiceEntity>>> call({int page = 1}) {
    return _repository.getServices(page: page);
  }
}
