import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../domain/entities/service_entity.dart';
import 'widgets/service_details_actions.dart';
import 'widgets/service_details_description.dart';
import 'widgets/service_details_features.dart';
import 'widgets/service_details_image_header.dart';

/// Screen – Service Details (Stateless)
class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ModalRoute.of(context)!.settings.arguments as ServiceEntity;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: CustomScrollView(
        slivers: [
          ServiceDetailsImageHeader(service: service),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceDetailsDescription(service: service),
                  ServiceDetailsFeatures(service: service),
                  ServiceDetailsActions(service: service),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
