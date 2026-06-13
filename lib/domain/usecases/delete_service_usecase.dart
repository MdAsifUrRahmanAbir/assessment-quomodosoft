import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../repository/service_repository.dart';

/// Use case: Delete a service by its [id].
class DeleteServiceUseCase {
  const DeleteServiceUseCase(this._repository);

  final ServiceRepository _repository;

  /// Returns [true] on successful deletion.
  Future<Either<Failure, bool>> call(String id) {
    return _repository.deleteService(id);
  }
}
