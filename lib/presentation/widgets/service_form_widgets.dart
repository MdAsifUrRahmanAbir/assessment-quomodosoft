import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

// ─────────────────────────────────────────────────────────────
// Shared image upload box widget used in create & update screens
// ─────────────────────────────────────────────────────────────
class ImageUploadBox extends StatelessWidget {
  const ImageUploadBox({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.chipBg,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image_outlined,
                color: AppColors.primary, size: AppSizes.iconXL),
            const SizedBox(height: AppSizes.paddingXS),
            Text(
              'Browser Image',
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontSize: AppSizes.fontM,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Category dropdown
// ─────────────────────────────────────────────────────────────
class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category*',
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontS,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: AppSizes.paddingXS),
        Container(
          height: AppSizes.inputHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textMedium),
              style: GoogleFonts.poppins(
                  fontSize: AppSizes.fontM, color: AppColors.textDark),
              onChanged: onChanged,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Package features dynamic list
// ─────────────────────────────────────────────────────────────
class PackageFeaturesSection extends StatelessWidget {
  const PackageFeaturesSection({
    super.key,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
  });

  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Package Features',
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontL,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: AppSizes.paddingM),

        ...List.generate(controllers.length, (i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Service*',
                    style: GoogleFonts.poppins(
                      fontSize: AppSizes.fontS,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                  if (i > 0) ...[
                    const Spacer(),
                    GestureDetector(
                      onTap: () => onRemove(i),
                      child: const Icon(Icons.close,
                          color: AppColors.danger, size: 18),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSizes.paddingXS),
              TextFormField(
                controller: controllers[i],
                style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontM, color: AppColors.textDark),
                decoration: InputDecoration(
                  hintText: 'e.g. 4 Unique Header Style',
                  filled: true,
                  fillColor: AppColors.inputBg,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                    vertical: AppSizes.paddingM,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    borderSide: const BorderSide(color: AppColors.inputBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    borderSide: const BorderSide(color: AppColors.inputBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.textLight, fontSize: AppSizes.fontM),
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
            ],
          );
        }),

        GestureDetector(
          onTap: onAdd,
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(AppSizes.paddingXS),
                ),
                child: const Icon(Icons.add, color: AppColors.primary, size: 16),
              ),
              const SizedBox(width: AppSizes.paddingS),
              Text(
                'Add New',
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                  fontSize: AppSizes.fontM,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
