import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import 'dashboard_avatar.dart';
import 'dashboard_header_painters.dart';
import 'dashboard_pill.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HeaderBackgroundPainter(),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.headerStart, AppColors.headerEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppSizes.paddingXL),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingL, AppSizes.paddingM, AppSizes.paddingL, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const DashboardPill(label: 'USD', icon: Icons.attach_money_rounded),
                const SizedBox(width: AppSizes.paddingS),
                const DashboardPill(label: 'Eng', icon: Icons.language_rounded),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFBBF24), width: 1.5),
                    color: AppColors.primaryLight,
                  ),
                  child: const DashboardAvatar(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const DashedDivider(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Balance',
                      style: GoogleFonts.inter(
                        color: AppColors.textWhite.withValues(alpha: 0.8),
                        fontSize: AppSizes.fontS,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$947.00',
                      style: GoogleFonts.inter(
                        color: AppColors.textWhite,
                        fontSize: AppSizes.fontDisplay,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Withdraw',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: AppSizes.fontM,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
