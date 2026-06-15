import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ServiceCardRating extends StatelessWidget {
  const ServiceCardRating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(
            Icons.star_rounded,
            color: AppColors.starColor,
            size: 14,
          );
        } else if (i < rating) {
          return const Icon(
            Icons.star_half_rounded,
            color: AppColors.starColor,
            size: 14,
          );
        } else {
          return const Icon(
            Icons.star_border_rounded,
            color: AppColors.textLight,
            size: 14,
          );
        }
      }),
    );
  }
}
