import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../repository/service_repository.dart';

/// Use case: Fetch all active categories from remote API.
class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final ServiceRepository _repository;

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return _repository.getCategories();
  }
}
