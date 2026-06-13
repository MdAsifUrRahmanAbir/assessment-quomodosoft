import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_assets.dart';

/// Floating pill-shaped bottom navigation bar matching the Figma design.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      height: AppSizes.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _NavItem(
            iconPath: currentIndex == 0 ? AppAssets.homeActive : AppAssets.home,
            label: 'Home',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            iconPath: currentIndex == 1 ? AppAssets.serviceActive : AppAssets.service,
            label: 'Service',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: AppSizes.iconL,
              height: AppSizes.iconL,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.primary : AppColors.textLight,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: AppSizes.fontS,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

