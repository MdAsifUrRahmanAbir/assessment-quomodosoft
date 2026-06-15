import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class DashboardPill extends StatelessWidget {
  final String label;
  final IconData icon;

  const DashboardPill({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textWhite, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.textWhite,
              fontSize: AppSizes.fontS,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textWhite, size: 16),
        ],
      ),
    );
  }
}
