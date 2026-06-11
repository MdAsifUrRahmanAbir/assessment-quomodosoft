import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/service_form_widgets.dart';

/// Screen – Update Service (Edit)
class UpdateServiceScreen extends StatefulWidget {
  const UpdateServiceScreen({super.key});

  @override
  State<UpdateServiceScreen> createState() => _UpdateServiceScreenState();
}

class _UpdateServiceScreenState extends State<UpdateServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl =
      TextEditingController(text: 'Confident experience smart recording');
  final _priceCtrl = TextEditingController(text: '\$188');
  final _descCtrl = TextEditingController(
      text: 'Professional video recording and vlogging services for creators.');
  String _selectedCategory = 'Vloggers';
  final List<TextEditingController> _featureCtrs = [
    TextEditingController(text: '4 Unique Header Style'),
    TextEditingController(text: 'HD Quality Recording'),
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

  void _onUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service updated successfully!',
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

                PackageFeaturesSection(
                  controllers: _featureCtrs,
                  onAdd: _addFeature,
                  onRemove: _removeFeature,
                ),

                const SizedBox(height: AppSizes.paddingXL),

                PrimaryButton(label: 'Update Service', onPressed: _onUpdate),

                const SizedBox(height: AppSizes.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
