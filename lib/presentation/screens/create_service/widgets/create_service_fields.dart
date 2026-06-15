import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/service_form_widgets.dart';

class CreateServiceFields extends StatefulWidget {
  const CreateServiceFields({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  State<CreateServiceFields> createState() => _CreateServiceFieldsState();
}

class _CreateServiceFieldsState extends State<CreateServiceFields> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
    });
  }

  Future<void> _loadCategories() async {
    final cubit = context.read<ServiceCubit>();
    if (cubit.categories.isNotEmpty) {
      setState(() {
        cubit.loadingCategoriesForCreate = false;
        if (cubit.selectedCategoryForCreate == null) {
          cubit.selectedCategoryForCreate = cubit.categories.first;
        }
      });
      return;
    }
    final cats = await cubit.getCategories();
    if (mounted) {
      setState(() {
        cubit.categories = cats;
        if (cubit.categories.isNotEmpty) {
          cubit.selectedCategoryForCreate = cubit.categories.first;
        }
        cubit.loadingCategoriesForCreate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInputField(
          label: 'Service Name*',
          hint: 'Name here',
          controller: cubit.createNameCtrl,
          enabled: !widget.isLoading,
          validator: (v) => (v == null || v.isEmpty)
              ? 'Service name is required'
              : null,
        ),
        const SizedBox(height: AppSizes.paddingM),
        Row(
          children: [
            Expanded(
              child: AppInputField(
                label: 'Price Range*',
                hint: '50',
                controller: cubit.createPriceCtrl,
                keyboardType: TextInputType.number,
                enabled: !widget.isLoading,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Required' : null,
              ),
            ),
            const SizedBox(width: AppSizes.paddingM),
            Expanded(
              child: cubit.selectedCategoryForCreate == null
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    )
                  : CategoryDropdown<CategoryEntity>(
                      value: cubit.selectedCategoryForCreate!,
                      items: cubit.categories,
                      itemAsString: (cat) => cat.name,
                      onChanged: (val) {
                        if (!widget.isLoading) {
                          setState(() {
                            cubit.selectedCategoryForCreate =
                                val ?? cubit.selectedCategoryForCreate;
                          });
                        }
                      },
                    ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.paddingM),
        AppInputField(
          label: 'Description*',
          hint: 'Description here',
          controller: cubit.createDescCtrl,
          maxLines: 4,
          enabled: !widget.isLoading,
          validator: (v) => (v == null || v.isEmpty)
              ? 'Description is required'
              : null,
        ),
      ],
    );
  }
}
