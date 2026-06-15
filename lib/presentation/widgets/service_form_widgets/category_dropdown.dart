import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDropdown<T> extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemAsString,
  });

  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemAsString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
            children: const [
              TextSpan(text: 'Category'),
              TextSpan(
                text: '*',
                style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFEFF6FF), width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF1F2937),
                size: 24,
              ),
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w400,
              ),
              onChanged: onChanged,
              items: items
                  .map((e) => DropdownMenuItem<T>(
                        value: e,
                        child: Text(itemAsString(e)),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
