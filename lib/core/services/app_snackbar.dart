import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

/// Centralised snackbar utility using global navigatorKey.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppSnackBar {
  AppSnackBar._();

  static void success(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle_rounded,
    );
  }

  static void error(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.danger,
      icon: Icons.warning_rounded,
    );
  }

  static void info(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: const Color(0xFF3B82F6), // blue info color
      icon: Icons.info_rounded,
    );
  }

  static void warning(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.warning,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void _showSnackBar({
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: AppSizes.fontM,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }

  static void showServerErrorDialog() {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        title: Row(
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.warning, size: 28),
            const SizedBox(width: 8),
            Text(
              'Server Error',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: AppSizes.fontXL,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        content: Text(
          'We encountered an unexpected server issue. Please try again later.',
          style: GoogleFonts.poppins(
            color: AppColors.textMedium,
            fontSize: AppSizes.fontM,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogCtx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
            ),
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
