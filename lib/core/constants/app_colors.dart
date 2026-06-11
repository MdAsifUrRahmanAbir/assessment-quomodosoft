import 'package:flutter/material.dart';

/// Centralized color palette matching the Figma design.
class AppColors {
  AppColors._();

  // ── Brand / Primary ──────────────────────────────────────────
  static const Color primary       = Color(0xFF6B21FF); // violet-purple
  static const Color primaryDark   = Color(0xFF5218CC);
  static const Color primaryLight  = Color(0xFF8B5CF6);

  // ── Background ───────────────────────────────────────────────
  static const Color scaffold      = Color(0xFFFFFFFF);
  static const Color cardBg        = Color(0xFFFFFFFF);
  static const Color inputBg       = Color(0xFFF5F5F5);
  static const Color chipBg        = Color(0xFFF0EAFF); // light purple tint

  // ── Dashboard header gradient stops ──────────────────────────
  static const Color headerStart   = Color(0xFF7B3FFF);
  static const Color headerEnd     = Color(0xFF5A1BE8);

  // ── Text ─────────────────────────────────────────────────────
  static const Color textDark      = Color(0xFF1A1A2E);
  static const Color textMedium    = Color(0xFF4B5563);
  static const Color textLight     = Color(0xFF9CA3AF);
  static const Color textWhite     = Color(0xFFFFFFFF);

  // ── Status ───────────────────────────────────────────────────
  static const Color success       = Color(0xFF22C55E);
  static const Color warning       = Color(0xFFF59E0B);
  static const Color danger        = Color(0xFFEF4444);
  static const Color starColor     = Color(0xFFF59E0B);

  // ── Misc ─────────────────────────────────────────────────────
  static const Color divider       = Color(0xFFE5E7EB);
  static const Color shadow        = Color(0x14000000);
  static const Color negative      = Color(0xFF6B21FF); // withdrawal in purple
  static const Color positiveGreen = Color(0xFF22C55E);

  // ── Border ───────────────────────────────────────────────────
  static const Color border        = Color(0xFFE0D4FF);
  static const Color inputBorder   = Color(0xFFD1D5DB);
}
