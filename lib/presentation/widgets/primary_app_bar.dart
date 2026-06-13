import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

/// Reusable primary AppBar matching Figma mockups.
class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffold,
      elevation: 0,
      leadingWidth: 56,
      leading: showBackButton
          ? Center(
              child: GestureDetector(
                onTap: onBackPressed ?? () => Navigator.maybePop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.textDark,
                    size: 24,
                  ),
                ),
              ),
            )
          : null,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: const Color(0xFF0F172A), // Slate-900
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
