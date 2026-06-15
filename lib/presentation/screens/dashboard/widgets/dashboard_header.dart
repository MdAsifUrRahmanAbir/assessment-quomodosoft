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
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.headerStart, AppColors.headerEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSizes.paddingXL)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSizes.paddingXL)),
              child: Image.asset('assets/icon/dashboardBg.png', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(AppSizes.paddingL, topPadding + AppSizes.paddingS, AppSizes.paddingL, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),

                Row(
                  children: [
                    const DashboardPill(label: 'USD', icon: Icons.attach_money_rounded),
                    const SizedBox(width: AppSizes.paddingM),
                    const DashboardPill(label: 'Eng', icon: Icons.language_rounded),
                    const Spacer(),
                    const SizedBox(width: 40, height: 40, child: DashboardAvatar()),
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
                        Text('My Balance',
                          style: GoogleFonts.inter(color: AppColors.textWhite.withValues(alpha: 0.8), fontSize: AppSizes.fontS, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text('\$947.00',
                          style: GoogleFonts.inter(color: AppColors.textWhite, fontSize: AppSizes.fontDisplay, fontWeight: FontWeight.w700, height: 1.1),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(color: AppColors.textWhite, borderRadius: BorderRadius.circular(10)),
                      child: Text('Withdraw',
                        style: GoogleFonts.inter(color: Colors.black, fontSize: AppSizes.fontM, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
