import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../bloc/auth/sign_in_cubit.dart';

class SignInRememberMe extends StatelessWidget {
  final SignInCubit cubit;
  final SignInState state;
  final bool isLoading;

  const SignInRememberMe({
    super.key,
    required this.cubit,
    required this.state,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: isLoading ? null : () => cubit.toggleRememberMe(),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: state.rememberMe ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: state.rememberMe ? AppColors.primary : const Color(0xFFCBD5E1),
                    width: 1.5,
                  ),
                ),
                child: state.rememberMe
                    ? const Icon(Icons.check, color: AppColors.textWhite, size: 14)
                    : null,
              ),
              const SizedBox(width: 8),
              Text(
                'Remember Me',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.danger,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
