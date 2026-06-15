import 'dart:convert';
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
    this.translateId,
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
  final int? translateId;

  // ── fromJson ──────────────────────────────────────────────────────────────
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    // If the json has a nested 'service' object, extract fields from it
    final Map<String, dynamic> data = json.containsKey('service') 
        ? json['service'] as Map<String, dynamic> 
        : json;

    // Check for nested 'translate' object to get translateId
    int? parsedTranslateId;
    if (json.containsKey('translate')) {
      final translateData = json['translate'];
      if (translateData is Map) {
        parsedTranslateId = translateData['id'] as int?;
      }
    } else if (json.containsKey('translate_id')) {
      parsedTranslateId = json['translate_id'] as int?;
    } else if (data.containsKey('translate_id')) {
      parsedTranslateId = data['translate_id'] as int?;
    }

    // Parse price safely from String or num
    final double parsedPrice = double.tryParse(data['price']?.toString() ?? '') ?? 
                               (data['price'] as num?)?.toDouble() ?? 0.0;

    // Parse active state from status flag or is_active bool
    final bool parsedIsActive = data['is_active'] as bool? ?? 
                                (data['status']?.toString().toLowerCase() == 'active');

    // Parse average rating and review count safely from string or num keys
    final double parsedRating = double.tryParse(data['average_rating']?.toString() ?? '') ?? 
                                (data['rating'] as num?)?.toDouble() ?? 0.0;
    
    final int parsedReviewCount = (data['total_review'] as num?)?.toInt() ?? 
                                  (data['review_count'] as num?)?.toInt() ?? 0;

    // Parse thumbnail or standard image url
    final String parsedImageUrl = data['thumbnail_image'] as String? ?? 
                                  data['image_url'] as String? ?? '';

    // Parse created date
    final String parsedDate = data['created_at'] as String? ?? 
                              data['date'] as String? ?? '';

    // Parse category name from map or string representation
    String parsedCategory = '';
    final categoryData = data['category'];
    if (categoryData is Map) {
      parsedCategory = categoryData['name']?.toString() ?? '';
    } else if (categoryData != null) {
      parsedCategory = categoryData.toString();
    }

    // If category name is empty, try resolving from categories sibling list
    if (parsedCategory.isEmpty) {
      final int? catId = data['category_id'] as int?;
      if (catId != null && json.containsKey('categories')) {
        final categoriesList = json['categories'] as List?;
        final matched = categoriesList?.firstWhere(
          (c) => c is Map && c['id'] == catId,
          orElse: () => null,
        );
        if (matched != null) {
          parsedCategory = matched['name']?.toString() ?? '';
        }
      }
    }

    // Parse features (handling both json arrays and raw stringified arrays)
    List<String> parsedFeatures = [];
    final rawFeatures = data['features'];
    if (rawFeatures is String && rawFeatures.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawFeatures);
        if (decoded is List) {
          parsedFeatures = decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    } else if (rawFeatures is List) {
      parsedFeatures = rawFeatures.map((e) => e.toString()).toList();
    }

    // Fallback for title/description from translate mapping if not in service
    String parsedTitle = data['title'] as String? ?? '';
    String parsedDescription = data['description'] as String? ?? '';

    if (json.containsKey('translate')) {
      final translateData = json['translate'];
      if (translateData is Map) {
        if (parsedTitle.isEmpty) {
          parsedTitle = translateData['title'] as String? ?? '';
        }
        if (parsedDescription.isEmpty) {
          parsedDescription = translateData['description'] as String? ?? '';
        }
      }
    }

    return ServiceModel(
      id: (data['id'] ?? '').toString(),
      title: parsedTitle,
      category: parsedCategory.isNotEmpty ? parsedCategory : (data['category_id'] ?? '').toString(),
      price: parsedPrice,
      rating: parsedRating,
      reviewCount: parsedReviewCount,
      imageUrl: parsedImageUrl,
      date: parsedDate,
      isActive: parsedIsActive,
      description: parsedDescription,
      features: parsedFeatures,
      translateId: parsedTranslateId,
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
      if (translateId != null) 'translate_id': translateId,
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
      translateId: translateId,
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
      translateId: entity.translateId,
    );
  }
}
