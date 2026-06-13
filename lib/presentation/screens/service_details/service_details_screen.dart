import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../../../domain/entities/service_entity.dart';
import '../../widgets/primary_button.dart';

/// Screen – Service Details (BLoC-driven dynamic args)
class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ModalRoute.of(context)!.settings.arguments as ServiceEntity;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: CustomScrollView(
        slivers: [
          // ── Image header ─────────────────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.scaffold,
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
                    service.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: AppColors.chipBg,
                      child: const Icon(Icons.image_not_supported_outlined,
                          color: AppColors.primary, size: 64),
                    ),
                  ),
                  // Gradient overlay
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
                  // Price + Active badge
                  Positioned(
                    bottom: AppSizes.paddingM,
                    left: AppSizes.paddingM,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingS, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.textDark,
                            borderRadius: BorderRadius.circular(AppSizes.radiusS),
                          ),
                          child: Text('\$${service.price.toStringAsFixed(0)}',
                              style: GoogleFonts.poppins(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppSizes.fontM)),
                        ),
                        const SizedBox(width: AppSizes.paddingS),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: service.isActive ? AppColors.success : AppColors.textLight,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusFull),
                          ),
                          child: Text(service.isActive ? 'Active' : 'Inactive',
                              style: GoogleFonts.poppins(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppSizes.fontXS)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Details body ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + Rating
                  Row(
                    children: [
                      Text(service.category,
                          style: GoogleFonts.poppins(
                              fontSize: AppSizes.fontS,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500)),
                      const Spacer(),
                      const Icon(Icons.star_rounded,
                          color: AppColors.starColor, size: 16),
                      const SizedBox(width: 4),
                      Text('${service.rating} (${service.reviewCount} Reviews)',
                          style: GoogleFonts.poppins(
                              fontSize: AppSizes.fontS,
                              color: AppColors.textMedium)),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingS),

                  // Title
                  Text(
                    service.title,
                    style: GoogleFonts.poppins(
                        fontSize: AppSizes.fontXL,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark),
                  ),
                  const SizedBox(height: AppSizes.paddingS),

                  // Date
                  Text(service.date,
                      style: GoogleFonts.poppins(
                          fontSize: AppSizes.fontXS,
                          color: AppColors.textLight)),

                  const SizedBox(height: AppSizes.paddingL),
                  const Divider(color: AppColors.divider),
                  const SizedBox(height: AppSizes.paddingM),

                  // Description
                  Text('Description',
                      style: GoogleFonts.poppins(
                          fontSize: AppSizes.fontL,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark)),
                  const SizedBox(height: AppSizes.paddingS),
                  Text(
                    service.description.isNotEmpty
                        ? service.description
                        : 'No description available.',
                    style: GoogleFonts.poppins(
                        fontSize: AppSizes.fontM,
                        color: AppColors.textMedium,
                        height: 1.6),
                  ),

                  const SizedBox(height: AppSizes.paddingL),

                  // Package Features
                  if (service.features.isNotEmpty) ...[
                    Text('Package Features',
                        style: GoogleFonts.poppins(
                            fontSize: AppSizes.fontL,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark)),
                    const SizedBox(height: AppSizes.paddingM),
                    ...service.features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.paddingS),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: AppColors.chipBg,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusFull),
                              ),
                              child: const Icon(Icons.check,
                                  color: AppColors.primary, size: 14),
                            ),
                            const SizedBox(width: AppSizes.paddingS),
                            Text(feature,
                                style: GoogleFonts.poppins(
                                    fontSize: AppSizes.fontM,
                                    color: AppColors.textDark)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingXL),
                  ],

                  // Action buttons
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
