import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../bloc/navigation/navigation_cubit.dart';

class ServiceListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ServiceListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffold,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 56,
      leading: Center(
        child: GestureDetector(
          onTap: () => context.read<NavigationCubit>().setTab(0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: const Color(0xFFE2E8F0), width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.textDark,
              size: 24,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        'Services',
        style: GoogleFonts.inter(
          color: const Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
