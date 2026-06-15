import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../domain/entities/service_entity.dart';

class ServiceDetailsDescription extends StatelessWidget {
  final ServiceEntity service;

  const ServiceDetailsDescription({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(service.category,
                style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontS,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            const Icon(Icons.star_rounded,
                color: AppColors.starColor, size: 16),
            const SizedBox(width: 4),
            Text('${service.rating} (${service.reviewCount} Reviews)',
                style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontS,
                    color: AppColors.textMedium)),
          ],
        ),
        const SizedBox(height: AppSizes.paddingS),
        Text(
          service.title,
          style: GoogleFonts.poppins(
              fontSize: AppSizes.fontXL,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark),
        ),
        const SizedBox(height: AppSizes.paddingS),
        Text(service.date,
            style: GoogleFonts.poppins(
                fontSize: AppSizes.fontXS,
                color: AppColors.textLight)),
        const SizedBox(height: AppSizes.paddingL),
        const Divider(color: AppColors.divider),
        const SizedBox(height: AppSizes.paddingM),
        Text('Description',
            style: GoogleFonts.poppins(
                fontSize: AppSizes.fontL,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark)),
        const SizedBox(height: AppSizes.paddingS),
        Text(
          service.description.isNotEmpty
              ? service.description
              : 'No description available.',
          style: GoogleFonts.poppins(
              fontSize: AppSizes.fontM,
              color: AppColors.textMedium,
              height: 1.6),
        ),
      ],
    );
  }
}
