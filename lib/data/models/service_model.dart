import '../../domain/entities/service_entity.dart';

/// JSON-serializable Data Transfer Object (DTO) for a Service.
///
/// Responsible for parsing API responses and converting to/from [ServiceEntity].
class ServiceModel {
  const ServiceModel({
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

  // ── fromJson ──────────────────────────────────────────────────────────────
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: (json['id'] ?? '').toString(),
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      date: json['date'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      description: json['description'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  // ── toJson ────────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'rating': rating,
      'review_count': reviewCount,
      'image_url': imageUrl,
      'date': date,
      'is_active': isActive,
      'description': description,
      'features': features,
    };
  }

  // ── toEntity ──────────────────────────────────────────────────────────────
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      title: title,
      category: category,
      price: price,
      rating: rating,
      reviewCount: reviewCount,
      imageUrl: imageUrl,
      date: date,
      isActive: isActive,
      description: description,
      features: features,
    );
  }

  // ── fromEntity ────────────────────────────────────────────────────────────
  factory ServiceModel.fromEntity(ServiceEntity entity) {
    return ServiceModel(
      id: entity.id,
      title: entity.title,
      category: entity.category,
      price: entity.price,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      imageUrl: entity.imageUrl,
      date: entity.date,
      isActive: entity.isActive,
      description: entity.description,
      features: entity.features,
    );
  }
}
