import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import 'dashboard_stat_model.dart';

class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({super.key, required this.item});
  final DashboardStatModel item;

  @override
  Widget build(BuildContext context) {
    const brandColor = AppColors.primary;
    final isPending = item.icon == AppAssets.pendingOrder;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 36,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              item.icon,
              width: 26,
              height: 26,
              colorFilter: isPending
                  ? null
                  : const ColorFilter.mode(brandColor, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.value,
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A), height: 1),
                ),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: const Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
