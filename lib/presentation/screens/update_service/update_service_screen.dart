import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/services/app_snackbar.dart';
import '../../../domain/entities/service_entity.dart';
import '../../bloc/service/service_cubit.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/service_form_widgets.dart';

/// Screen – Update Service (Edit - BLoC-driven)
class UpdateServiceScreen extends StatelessWidget {
  const UpdateServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (_) => sl<ServiceCubit>(),
      child: const _UpdateServiceView(),
    );
  }
}

class _UpdateServiceView extends StatefulWidget {
  const _UpdateServiceView();

  @override
  State<_UpdateServiceView> createState() => _UpdateServiceViewState();
}

class _UpdateServiceViewState extends State<_UpdateServiceView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _selectedCategory = 'Vloggers';
  final List<TextEditingController> _featureCtrs = [];
  bool _initialized = false;
  late ServiceEntity _service;

  final List<String> _categories = [
    'Vloggers', 'Design', 'Development', 'Marketing', 'Writing', 'Photography',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _service = ModalRoute.of(context)!.settings.arguments as ServiceEntity;
      _nameCtrl.text = _service.title;
      _priceCtrl.text = _service.price.toStringAsFixed(0);
      _descCtrl.text = _service.description;
      _selectedCategory = _service.category;
      _featureCtrs.clear();
      for (final f in _service.features) {
        _featureCtrs.add(TextEditingController(text: f));
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    for (final c in _featureCtrs) {
      c.dispose();
    }
    super.dispose();
  }

  void _addFeature() =>
      setState(() => _featureCtrs.add(TextEditingController()));

  void _removeFeature(int index) {
    setState(() {
      _featureCtrs[index].dispose();
      _featureCtrs.removeAt(index);
    });
  }

  void _onUpdate(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final cleanPriceText = _priceCtrl.text.replaceAll(RegExp(r'[^\d.]'), '');
    final price = double.tryParse(cleanPriceText) ?? 50.0;

    final features = _featureCtrs
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final updatedService = _service.copyWith(
      title: _nameCtrl.text.trim(),
      category: _selectedCategory,
      price: price,
      description: _descCtrl.text.trim(),
      features: features,
    );

    context.read<ServiceCubit>().updateService(updatedService);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state is ServiceOperationSuccess) {
          AppSnackBar.success(state.message);
          Navigator.pop(context);
        } else if (state is ServiceError) {
          AppSnackBar.error(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is ServiceLoading;

        return Scaffold(
          backgroundColor: AppColors.scaffold,
          appBar: AppBar(
            backgroundColor: AppColors.scaffold,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(left: AppSizes.paddingM),
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
            title: Text(
              'Update Service',
              style: GoogleFonts.poppins(
                color: AppColors.textDark,
                fontSize: AppSizes.fontL,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.paddingM),

                    ImageUploadBox(onTap: () {}),

                    const SizedBox(height: AppSizes.paddingL),

                    AppInputField(
                      label: 'Service Name*',
                      hint: 'Name here',
                      controller: _nameCtrl,
                      enabled: !isLoading,
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
                            controller: _priceCtrl,
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingM),
                        Expanded(
                          child: CategoryDropdown(
                            value: _selectedCategory,
                            items: _categories,
                            onChanged: (val) {
                              if (!isLoading) {
                                setState(() =>
                                    _selectedCategory = val ?? _selectedCategory);
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
                      controller: _descCtrl,
                      maxLines: 4,
                      enabled: !isLoading,
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Description is required'
                          : null,
                    ),

                    const SizedBox(height: AppSizes.paddingL),

                    PackageFeaturesSection(
                      controllers: _featureCtrs,
                      onAdd: _addFeature,
                      onRemove: _removeFeature,
                    ),

                    const SizedBox(height: AppSizes.paddingXL),

                    PrimaryButton(
                      label: isLoading ? 'Updating...' : 'Update Service',
                      onPressed: isLoading ? () {} : () => _onUpdate(context),
                    ),

                    const SizedBox(height: AppSizes.paddingXL),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
