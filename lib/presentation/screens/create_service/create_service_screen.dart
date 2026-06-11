import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/service_form_widgets.dart';

/// Screen 04 – Add New Service (Create)
class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController(text: '\$50');
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

  void _onPublish() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service published successfully!',
              style: GoogleFonts.poppins()),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        hint: '\$50',
                        controller: _priceCtrl,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingM),
                    Expanded(
                      child: CategoryDropdown(
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (val) => setState(
                            () => _selectedCategory = val ?? _selectedCategory),
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
                PrimaryButton(label: 'Publish Service', onPressed: _onPublish),

                const SizedBox(height: AppSizes.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
