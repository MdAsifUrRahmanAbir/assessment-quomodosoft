import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/service_form_widgets.dart';

class UpdateServiceFields extends StatefulWidget {
  const UpdateServiceFields({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  State<UpdateServiceFields> createState() => _UpdateServiceFieldsState();
}

class _UpdateServiceFieldsState extends State<UpdateServiceFields> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInputField(
          label: 'Service Name*',
          hint: 'Name here',
          controller: cubit.updateNameCtrl,
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
                controller: cubit.updatePriceCtrl,
                keyboardType: TextInputType.number,
                enabled: !widget.isLoading,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Required' : null,
              ),
            ),
            const SizedBox(width: AppSizes.paddingM),
            Expanded(
              child: cubit.selectedCategoryForUpdate == null
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    )
                  : CategoryDropdown<CategoryEntity>(
                      value: cubit.selectedCategoryForUpdate!,
                      items: cubit.categories,
                      itemAsString: (cat) => cat.name,
                      onChanged: (val) {
                        if (!widget.isLoading) {
                          setState(() {
                            cubit.selectedCategoryForUpdate =
                                val ?? cubit.selectedCategoryForUpdate;
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
          controller: cubit.updateDescCtrl,
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
