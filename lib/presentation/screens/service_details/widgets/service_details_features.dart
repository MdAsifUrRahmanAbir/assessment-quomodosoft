import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../domain/entities/service_entity.dart';

class ServiceDetailsFeatures extends StatelessWidget {
  final ServiceEntity service;

  const ServiceDetailsFeatures({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    if (service.features.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSizes.paddingL),
        Text('Package Features',
            style: GoogleFonts.poppins(
                fontSize: AppSizes.fontL,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark)),
        const SizedBox(height: AppSizes.paddingM),
        ...service.features.map(
          (feature) => Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.paddingS),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.chipBg,
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusFull),
                  ),
                  child: const Icon(Icons.check,
                      color: AppColors.primary, size: 14),
                ),
                const SizedBox(width: AppSizes.paddingS),
                Text(feature,
                    style: GoogleFonts.poppins(
                        fontSize: AppSizes.fontM,
                        color: AppColors.textDark)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
