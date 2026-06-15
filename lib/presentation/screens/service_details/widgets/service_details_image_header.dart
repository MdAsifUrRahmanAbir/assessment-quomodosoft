import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/services/api_endpoint.dart';
import '../../../../domain/entities/service_entity.dart';

class ServiceDetailsImageHeader extends StatelessWidget {
  final ServiceEntity service;

  const ServiceDetailsImageHeader({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final cleanUrl = service.imageUrl.startsWith('/') ? service.imageUrl.substring(1) : service.imageUrl;
    final formattedUrl = service.imageUrl.startsWith('http') ? service.imageUrl : "${ApiEndpoint.mainDomain}/$cleanUrl";

    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.scaffold,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(left: AppSizes.paddingM, top: 8),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.inputBg,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark, size: AppSizes.iconS),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              formattedUrl,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Container(
                color: AppColors.chipBg,
                child: const Icon(Icons.image_not_supported_outlined,
                    color: AppColors.primary, size: 64),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: AppSizes.paddingM,
              left: AppSizes.paddingM,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingS, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.textDark, borderRadius: BorderRadius.circular(AppSizes.radiusS)),
                    child: Text('\$${service.price.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(color: AppColors.textWhite, fontWeight: FontWeight.w700, fontSize: AppSizes.fontM)),
                  ),
                  const SizedBox(width: AppSizes.paddingS),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: service.isActive ? AppColors.success : AppColors.textLight,
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                    child: Text(service.isActive ? 'Active' : 'Inactive',
                        style: GoogleFonts.poppins(color: AppColors.textWhite, fontWeight: FontWeight.w600, fontSize: AppSizes.fontXS)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
