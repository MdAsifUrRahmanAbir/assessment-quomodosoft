import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/app_snackbar.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/service_card.dart';
import 'service_list_add_button.dart';
import 'service_list_delete_dialog.dart';
import 'service_list_empty_state.dart';
import 'service_list_loader.dart';

class ServiceListView extends StatelessWidget {
  const ServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
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
        final bool isLoadingMore = state is ServiceLoaded && state.isLoadingMore;

        if (state is ServiceLoaded) {
          services = state.services;
        } else {
          services = const [];
        }

        return Column(
          children: [
            const ServiceListAddButton(),
            const SizedBox(height: AppSizes.paddingM),
            Expanded(
              child: isLoading
                  ? const ServiceListLoader()
                  : services.isEmpty
                      ? const ServiceListEmptyState()
                      : RefreshIndicator(
                          color: AppColors.primary,
                          onRefresh: () => context.read<ServiceCubit>().loadServices(),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
                                context.read<ServiceCubit>().loadMoreServices();
                              }
                              return true;
                            },
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(
                                  AppSizes.paddingM, 0, AppSizes.paddingM, 120),
                              itemCount: services.length + (isLoadingMore ? 1 : 0),
                              itemBuilder: (context, i) {
                                if (i == services.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                                }

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
                                  onDelete: () => showDeleteServiceDialog(context, s.id),
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ],
        );
      },
    );
  }
}
