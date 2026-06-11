import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

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
        margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image with overlays ───────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusL),
              ),
              child: Stack(
                children: [
                  // Thumbnail
                  Image.network(
                    imageUrl,
                    height: AppSizes.serviceCardHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      height: AppSizes.serviceCardHeight,
                      color: AppColors.chipBg,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.primary,
                        size: 48,
                      ),
                    ),
                  ),
                  // Active badge
                  Positioned(
                    top: AppSizes.paddingM,
                    left: AppSizes.paddingM,
                    child: _ActiveBadge(isActive: isActive),
                  ),
                  // Action buttons (edit / delete)
                  Positioned(
                    top: AppSizes.paddingS,
                    right: AppSizes.paddingS,
                    child: Row(
                      children: [
                        _ActionIconButton(
                          icon: Icons.edit_outlined,
                          color: AppColors.primary,
                          bgColor: AppColors.chipBg,
                          onTap: onEdit,
                        ),
                        const SizedBox(width: AppSizes.paddingXS),
                        _ActionIconButton(
                          icon: Icons.delete_outline_rounded,
                          color: AppColors.danger,
                          bgColor: const Color(0xFFFFEEEE),
                          onTap: onDelete,
                        ),
                      ],
                    ),
                  ),
                  // Price badge
                  Positioned(
                    bottom: AppSizes.paddingM,
                    left: AppSizes.paddingM,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingS,
                        vertical: AppSizes.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textDark,
                        borderRadius: BorderRadius.circular(AppSizes.radiusS),
                      ),
                      child: Text(
                        '\$${price.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          color: AppColors.textWhite,
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ── Card body ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + Rating row
                  Row(
                    children: [
                      Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.fontS,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      _StarRating(rating: rating),
                      const SizedBox(width: 4),
                      Text(
                        '$reviewCount Reviews',
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.fontXS,
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingXS),
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: AppSizes.fontL,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingXS),
                  // Date
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontSize: AppSizes.fontXS,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge({required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.success : AppColors.textLight,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: GoogleFonts.poppins(
          color: AppColors.textWhite,
          fontSize: AppSizes.fontXS,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({
    required this.icon,
    required this.color,
    required this.bgColor,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusS),
        ),
        child: Icon(icon, color: color, size: AppSizes.iconS),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star_rounded,
              color: AppColors.starColor, size: 14);
        } else if (i < rating) {
          return const Icon(Icons.star_half_rounded,
              color: AppColors.starColor, size: 14);
        } else {
          return const Icon(Icons.star_border_rounded,
              color: AppColors.textLight, size: 14);
        }
      }),
    );
  }
}
