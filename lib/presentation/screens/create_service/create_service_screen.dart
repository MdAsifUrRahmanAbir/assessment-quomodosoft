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

/// Screen 04 – Add New Service (Create - BLoC-driven)
class CreateServiceScreen extends StatelessWidget {
  const CreateServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (_) => sl<ServiceCubit>(),
      child: const _CreateServiceView(),
    );
  }
}

class _CreateServiceView extends StatefulWidget {
  const _CreateServiceView();

  @override
  State<_CreateServiceView> createState() => _CreateServiceViewState();
}

class _CreateServiceViewState extends State<_CreateServiceView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController(text: '50');
  final _descCtrl = TextEditingController();
  String _selectedCategory = 'Vloggers';
  final List<TextEditingController> _featureCtrs = [
    TextEditingController(text: '4 Unique Header Style'),
  ];

  final List<String> _categories = [
    'Vloggers', 'Design', 'Development', 'Marketing', 'Writing', 'Photography',
  ];

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

  void _onPublish(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Parse price safely
    final cleanPriceText = _priceCtrl.text.replaceAll(RegExp(r'[^\d.]'), '');
    final price = double.tryParse(cleanPriceText) ?? 50.0;

    // Collect features
    final features = _featureCtrs
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final newService = ServiceEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _nameCtrl.text.trim(),
      category: _selectedCategory,
      price: price,
      rating: 5.0,
      reviewCount: 0,
      imageUrl: 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800',
      date: '13 Jun, 2026',
      isActive: true,
      description: _descCtrl.text.trim(),
      features: features,
    );

    context.read<ServiceCubit>().createService(newService);
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
              'Add New Services',
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

                    // ── Image upload ─────────────────────────────
                    ImageUploadBox(onTap: () {}),

                    const SizedBox(height: AppSizes.paddingL),

                    // ── Service Name ─────────────────────────────
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

                    // ── Price + Category ─────────────────────────
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

                    // ── Description ──────────────────────────────
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

                    // ── Package Features ─────────────────────────
                    PackageFeaturesSection(
                      controllers: _featureCtrs,
                      onAdd: _addFeature,
                      onRemove: _removeFeature,
                    ),

                    const SizedBox(height: AppSizes.paddingXL),

                    // ── Publish Button ───────────────────────────
                    PrimaryButton(
                      label: isLoading ? 'Publishing...' : 'Publish Service',
                      onPressed: isLoading ? () {} : () => _onPublish(context),
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
