import 'package:equatable/equatable.dart';

/// Pure business object representing a Category.
class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
