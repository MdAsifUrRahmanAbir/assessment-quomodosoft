import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/services/api_endpoint.dart';
import 'service_card_badge.dart';
import 'service_card_action_button.dart';

class ServiceCardThumbnail extends StatelessWidget {
  const ServiceCardThumbnail({
    super.key,
    required this.imageUrl,
    required this.isActive,
    required this.price,
    this.onEdit,
    this.onDelete,
  });

  final String imageUrl;
  final bool isActive;
  final double price;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final cleanUrl = imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
    final formattedUrl = imageUrl.startsWith('http') ? imageUrl : "${ApiEndpoint.mainDomain}/$cleanUrl";

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(
            formattedUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, stack) => Container(
              height: 160,
              color: const Color(0xFFF3F4F6),
              child: const Icon(Icons.image_not_supported_outlined, color: AppColors.primary, size: 48),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: ServiceCardBadge(isActive: isActive),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ServiceCardActionButton(iconPath: AppAssets.edit, onTap: onEdit),
                const SizedBox(width: 8),
                ServiceCardActionButton(iconPath: AppAssets.deleted, onTap: onDelete),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Text(
                '\$${price.toStringAsFixed(0)}',
                style: GoogleFonts.inter(color: const Color(0xFF2563EB), fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
