import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../bloc/service/service_cubit.dart';

class ServiceListAddButton extends StatelessWidget {
  const ServiceListAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM, AppSizes.paddingM, AppSizes.paddingM, 0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, AppRoutes.createService);
          if (context.mounted) {
            context.read<ServiceCubit>().loadServices();
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              vertical: AppSizes.paddingM),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius:
                BorderRadius.circular(AppSizes.radiusM),
            border: Border.all(
              color: AppColors.border,
              width: 1.5,
              style: BorderStyle.solid,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textMedium),
                  borderRadius:
                      BorderRadius.circular(AppSizes.paddingXS),
                ),
                child: const Icon(Icons.add,
                    color: AppColors.textMedium, size: 16),
              ),
              const SizedBox(width: AppSizes.paddingS),
              Text(
                'Add New Service',
                style: GoogleFonts.inter(
                  fontSize: AppSizes.fontM,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
