import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class ServiceListEmptyState extends StatelessWidget {
  const ServiceListEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.grid_off_rounded,
              size: 64, color: AppColors.textLight),
          const SizedBox(height: AppSizes.paddingM),
          Text(
            'No services yet',
            style: GoogleFonts.inter(
              fontSize: AppSizes.fontXL,
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            'Tap "+ Add New Service" to get started',
            style: GoogleFonts.inter(
              fontSize: AppSizes.fontM,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
