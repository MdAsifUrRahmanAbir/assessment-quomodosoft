import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'service_card_rating.dart';

class ServiceCardBody extends StatelessWidget {
  const ServiceCardBody({
    super.key,
    required this.title,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.date,
  });

  final String title;
  final String category;
  final double rating;
  final int reviewCount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category + Rating row
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light blue background
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                category,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF2563EB), // Blue text
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            ServiceCardRating(rating: rating),
            const SizedBox(width: 6),
            Text(
              '$reviewCount Reviews',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Title
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
