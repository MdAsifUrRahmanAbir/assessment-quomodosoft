import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/app_snackbar.dart';
import '../../../domain/entities/service_entity.dart';
import '../../bloc/service/service_cubit.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/service_card.dart';

/// Screen 03 – Services Listing (BLoC-driven)
class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (_) => sl<ServiceCubit>()..loadServices(),
      child: const _ServiceListView(),
    );
  }
}

class _ServiceListView extends StatefulWidget {
  const _ServiceListView();

  @override
  State<_ServiceListView> createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<_ServiceListView> {
  int _currentNavIndex = 1;

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      setState(() => _currentNavIndex = index);
    }
  }

  void _onDeleteService(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        title: Text(
          'Delete Service',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to delete this service?',
          style: GoogleFonts.poppins(color: AppColors.textMedium),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: AppColors.textMedium),
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
              style: GoogleFonts.poppins(color: AppColors.textWhite),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.dashboard),
          child: Container(
            margin: const EdgeInsets.only(left: AppSizes.paddingM),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark,
                size: AppSizes.iconS,
              ),
            ),
          ),
        ),
        title: Text(
          'Services',
          style: GoogleFonts.poppins(
            color: AppColors.textDark,
            fontSize: AppSizes.fontXL,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<ServiceCubit, ServiceState>(
          listener: (context, state) {
            if (state is ServiceOperationSuccess) {
              AppSnackBar.success(state.message);
            } else if (state is ServiceError) {
              AppSnackBar.error(state.message);
            }
          },
          builder: (context, state) {
            final List<ServiceEntity> services;
            final bool isLoading = state is ServiceLoading;

            if (state is ServiceLoaded) {
              services = state.services;
            } else {
              services = const [];
            }

            return Column(
              children: [
                // ── Add New Service button ─────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSizes.paddingM, AppSizes.paddingM, AppSizes.paddingM, 0),
                  child: GestureDetector(
                    onTap: () async {
                      // Navigate to create and reload again on return
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
                            style: GoogleFonts.poppins(
                              fontSize: AppSizes.fontM,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingM),

                // ── Service cards list ─────────────────────────────
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : services.isEmpty
                          ? _EmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                  AppSizes.paddingM, 0, AppSizes.paddingM, 120),
                              itemCount: services.length,
                              itemBuilder: (context, i) {
                                final s = services[i];
                                return ServiceCard(
                                  title: s.title,
                                  category: s.category,
                                  price: s.price,
                                  rating: s.rating,
                                  reviewCount: s.reviewCount,
                                  imageUrl: s.imageUrl,
                                  date: s.date,
                                  isActive: s.isActive,
                                  onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.serviceDetails,
                                      arguments: s),
                                  onEdit: () async {
                                    await Navigator.pushNamed(
                                        context, AppRoutes.updateService,
                                        arguments: s);
                                    if (context.mounted) {
                                      context.read<ServiceCubit>().loadServices();
                                    }
                                  },
                                  onDelete: () => _onDeleteService(context, s.id),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.grid_off_rounded,
              size: 64, color: AppColors.textLight),
          const SizedBox(height: AppSizes.paddingM),
          Text(
            'No services yet',
            style: GoogleFonts.poppins(
              fontSize: AppSizes.fontXL,
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            'Tap "+ Add New Service" to get started',
            style: GoogleFonts.poppins(
              fontSize: AppSizes.fontM,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
