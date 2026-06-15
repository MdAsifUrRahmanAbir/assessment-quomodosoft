import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../bloc/service/service_cubit.dart';

void showDeleteServiceDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      title: Text(
        'Delete Service',
        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
      content: Text(
        'Are you sure you want to delete this service?',
        style: GoogleFonts.inter(color: AppColors.textMedium),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogCtx),
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(color: AppColors.textMedium),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ServiceCubit>().deleteService(id);
            Navigator.pop(dialogCtx);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.danger,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
          ),
          child: Text(
            'Delete',
            style: GoogleFonts.inter(color: AppColors.textWhite),
          ),
        ),
      ],
    ),
  );
}
