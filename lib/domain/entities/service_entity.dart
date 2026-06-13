import 'package:equatable/equatable.dart';

/// Pure business object for a Service.
///
/// No JSON annotations, no Flutter dependencies.
/// Maps from [ServiceModel] in the data layer.
class ServiceEntity extends Equatable {
  const ServiceEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.date,
    required this.isActive,
    this.description = '',
    this.features = const [],
  });

  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String date;
  final bool isActive;
  final String description;
  final List<String> features;

  /// Returns a copy with overridden fields.
  ServiceEntity copyWith({
    String? id,
    String? title,
    String? category,
    double? price,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    String? date,
    bool? isActive,
    String? description,
    List<String>? features,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      features: features ?? this.features,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        price,
        rating,
        reviewCount,
        imageUrl,
        date,
        isActive,
        description,
        features,
      ];
}
