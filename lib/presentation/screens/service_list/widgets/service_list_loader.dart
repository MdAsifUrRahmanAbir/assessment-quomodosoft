import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class ServiceListLoader extends StatelessWidget {
  const ServiceListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3.5,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading Services...',
            style: GoogleFonts.inter(
              color: AppColors.textMedium,
              fontSize: AppSizes.fontM,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
