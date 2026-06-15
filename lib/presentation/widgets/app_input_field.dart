import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

/// Reusable labelled text input field with dynamic focus styling matching Figma.
class AppInputField extends StatelessWidget {
  AppInputField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
    this.fillColor,
    FocusNode? focusNode,
  }) : _focusNode = focusNode ?? FocusNode();

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    final Widget labelWidget = label.endsWith('*')
        ? RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
              children: [
                TextSpan(text: label.substring(0, label.length - 1)),
                const TextSpan(
                  text: '*',
                  style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        const SizedBox(height: 6),
        AnimatedBuilder(
          animation: _focusNode,
          builder: (context, child) {
            final isFocused = _focusNode.hasFocus;
            return TextFormField(
              controller: controller,
              obscureText: obscureText,
              enabled: enabled,
              keyboardType: keyboardType,
              validator: validator,
              maxLines: maxLines,
              onChanged: onChanged,
              focusNode: _focusNode,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                filled: true,
                fillColor: fillColor ?? (isFocused ? Colors.white : const Color(0xFFF8FAFC)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFEFF6FF), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFEFF6FF), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
