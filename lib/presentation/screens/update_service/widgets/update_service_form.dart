import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/primary_button.dart';
import 'update_service_feature_list.dart';
import 'update_service_fields.dart';
import 'update_service_image_picker.dart';

class UpdateServiceForm extends StatefulWidget {
  const UpdateServiceForm({
    super.key,
    required this.initialService,
    required this.isLoading,
  });

  final ServiceEntity initialService;
  final bool isLoading;

  @override
  State<UpdateServiceForm> createState() => _UpdateServiceFormState();
}

class _UpdateServiceFormState extends State<UpdateServiceForm> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // Synchronously pre-fill fields on the first frame
    final cubit = context.read<ServiceCubit>();
    cubit.editingService = widget.initialService;
    cubit.selectedImagePathForUpdate = widget.initialService.imageUrl;
    cubit.updateNameCtrl.text = widget.initialService.title;
    cubit.updatePriceCtrl.text = widget.initialService.price.toStringAsFixed(0);
    cubit.updateDescCtrl.text = widget.initialService.description;

    cubit.updateFeatureCtrs.clear();
    for (final f in widget.initialService.features) {
      cubit.updateFeatureCtrs.add(TextEditingController(text: f));
    }

    final parsedCatId = int.tryParse(widget.initialService.category);
    CategoryEntity? found;
    for (final c in cubit.categories) {
      if (c.id == parsedCatId || c.name.toLowerCase() == widget.initialService.category.toLowerCase()) {
        found = c;
        break;
      }
    }
    cubit.selectedCategoryForUpdate = found ?? (cubit.categories.isNotEmpty ? cubit.categories.first : null);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDetails();
    });
  }

  Future<void> _loadDetails() async {
    final cubit = context.read<ServiceCubit>();
    final categories = await cubit.getCategories();
    final details = await cubit.getServiceById(cubit.editingService.id);

    if (mounted) {
      setState(() {
        cubit.categories = categories;
        if (details != null) {
          cubit.editingService = details;
          cubit.updateNameCtrl.text = cubit.editingService.title;
          cubit.updatePriceCtrl.text = cubit.editingService.price.toStringAsFixed(0);
          cubit.updateDescCtrl.text = cubit.editingService.description;
          cubit.updateTranslateId = cubit.editingService.translateId;
          cubit.selectedImagePathForUpdate = cubit.editingService.imageUrl;

          final parsedCatId = int.tryParse(cubit.editingService.category);
          CategoryEntity? found;
          for (final c in cubit.categories) {
            if (c.id == parsedCatId || c.name.toLowerCase() == cubit.editingService.category.toLowerCase()) {
              found = c;
              break;
            }
          }
          cubit.selectedCategoryForUpdate = found ?? (cubit.categories.isNotEmpty ? cubit.categories.first : null);

          cubit.updateFeatureCtrs.clear();
          for (final f in cubit.editingService.features) {
            cubit.updateFeatureCtrs.add(TextEditingController(text: f));
          }
        } else {
          CategoryEntity? found;
          for (final c in cubit.categories) {
            if (c.name.toLowerCase() == cubit.editingService.category.toLowerCase()) {
              found = c;
              break;
            }
          }
          cubit.selectedCategoryForUpdate = found ?? (cubit.categories.isNotEmpty ? cubit.categories.first : null);
        }
        cubit.loadingDetailsForUpdate = false;
        _loading = false;
      });
    }
  }

  void _onUpdate() {
    final cubit = context.read<ServiceCubit>();
    if (!(cubit.updateFormKey.currentState?.validate() ?? false)) return;

    final cleanPriceText = cubit.updatePriceCtrl.text.replaceAll(RegExp(r'[^\d.]'), '');
    final price = double.tryParse(cleanPriceText) ?? 50.0;

    final features = cubit.updateFeatureCtrs
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final updatedService = cubit.editingService.copyWith(
      title: cubit.updateNameCtrl.text.trim(),
      category: cubit.selectedCategoryForUpdate?.id.toString() ?? cubit.editingService.category,
      price: price,
      description: cubit.updateDescCtrl.text.trim(),
      features: features,
      imageUrl: cubit.selectedImagePathForUpdate ?? cubit.editingService.imageUrl,
      translateId: cubit.updateTranslateId ?? cubit.editingService.translateId,
    );

    cubit.updateService(updatedService);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();
    final isPageLoading = widget.isLoading || _loading;

    return Form(
      key: cubit.updateFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpdateServiceImagePicker(isLoading: isPageLoading),
          const SizedBox(height: AppSizes.paddingL),
          UpdateServiceFields(isLoading: isPageLoading),
          const SizedBox(height: AppSizes.paddingL),
          const UpdateServiceFeatureList(),
          const SizedBox(height: AppSizes.paddingXL),
          PrimaryButton(
            label: isPageLoading ? 'Updating...' : 'Update Service',
            onPressed: isPageLoading ? () {} : _onUpdate,
          ),
          const SizedBox(height: AppSizes.paddingXL),
        ],
      ),
    );
  }
}
