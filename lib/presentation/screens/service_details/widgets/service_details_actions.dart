import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../widgets/primary_button.dart';

class ServiceDetailsActions extends StatelessWidget {
  final ServiceEntity service;

  const ServiceDetailsActions({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSizes.paddingXL),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final updated = await Navigator.pushNamed(
                      context, AppRoutes.updateService,
                      arguments: service);
                  if (context.mounted && updated != null) {
                    Navigator.pop(context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  ),
                  minimumSize:
                      const Size(double.infinity, AppSizes.buttonHeight),
                ),
                child: Text('Edit',
                    style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: AppSizes.fontL)),
              ),
            ),
            const SizedBox(width: AppSizes.paddingM),
            Expanded(
              child: PrimaryButton(
                label: 'Order Now',
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.paddingXL),
      ],
    );
  }
}
