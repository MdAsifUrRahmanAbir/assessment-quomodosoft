import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/services/app_snackbar.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/primary_button.dart';
import 'create_service_feature_list.dart';
import 'create_service_fields.dart';
import 'create_service_image_picker.dart';

class CreateServiceForm extends StatelessWidget {
  const CreateServiceForm({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  void _onPublish(BuildContext context) {
    final cubit = context.read<ServiceCubit>();
    if (!(cubit.createFormKey.currentState?.validate() ?? false)) return;
    if (cubit.selectedCategoryForCreate == null) {
      AppSnackBar.error('Please select a category');
      return;
    }
    if (cubit.selectedImagePathForCreate == null) {
      AppSnackBar.error('Please select a service image');
      return;
    }

    final cleanPriceText = cubit.createPriceCtrl.text.replaceAll(RegExp(r'[^\d.]'), '');
    final price = double.tryParse(cleanPriceText) ?? 50.0;

    final features = cubit.createFeatureCtrs
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final newService = ServiceEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: cubit.createNameCtrl.text.trim(),
      category: cubit.selectedCategoryForCreate!.id.toString(),
      price: price,
      rating: 5.0,
      reviewCount: 0,
      imageUrl: cubit.selectedImagePathForCreate!,
      date: '13 Jun, 2026',
      isActive: true,
      description: cubit.createDescCtrl.text.trim(),
      features: features,
    );

    cubit.createService(newService);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return Form(
      key: cubit.createFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateServiceImagePicker(isLoading: isLoading),
          const SizedBox(height: AppSizes.paddingL),
          CreateServiceFields(isLoading: isLoading),
          const SizedBox(height: AppSizes.paddingL),
          const CreateServiceFeatureList(),
          const SizedBox(height: AppSizes.paddingXL),
          PrimaryButton(
            label: isLoading ? 'Publishing...' : 'Publish Service',
            onPressed: isLoading ? () {} : () => _onPublish(context),
          ),
          const SizedBox(height: AppSizes.paddingXL),
        ],
      ),
    );
  }
}
