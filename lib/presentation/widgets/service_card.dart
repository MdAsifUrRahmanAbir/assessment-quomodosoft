import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'service_card/service_card_thumbnail.dart';
import 'service_card/service_card_body.dart';

/// Service card widget matching the Figma service listing design.
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.date,
    this.isActive = true,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  final String title;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String date;
  final bool isActive;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceCardThumbnail(
                imageUrl: imageUrl,
                isActive: isActive,
                price: price,
                onEdit: onEdit,
                onDelete: onDelete,
              ),
              const SizedBox(height: 12),
              ServiceCardBody(
                title: title,
                category: category,
                rating: rating,
                reviewCount: reviewCount,
                date: date,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
