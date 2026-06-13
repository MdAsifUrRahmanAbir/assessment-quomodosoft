import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../presentation/widgets/app_input_field.dart';
import '../../../bloc/auth/sign_in_cubit.dart';
import 'sign_in_button.dart';

/// Stateless Sign In form widget.
class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.isLoading,
    required this.state,
  });

  final bool isLoading;
  final SignInState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),

          // ── Headline ────────────────────────────────────────────
          Text(
            'Signin to Your Account',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A), // Slate-900
            ),
          ),

          const SizedBox(height: 32),

          // ── Username ────────────────────────────────────────────
          AppInputField(
            label: 'Username',
            hint: 'designslab',
            controller: cubit.usernameCtrl,
            keyboardType: TextInputType.text,
            enabled: !isLoading,
            validator: (v) =>
                (v == null || v.trim().isEmpty)
                    ? 'Enter your username'
                    : null,
          ),

          const SizedBox(height: 20),

          // ── Password ────────────────────────────────────────────
          AppInputField(
            label: 'Password',
            hint: 'Password',
            controller: cubit.passwordCtrl,
            obscureText: state.obscurePassword,
            enabled: !isLoading,
            validator: (v) =>
                (v == null || v.isEmpty)
                    ? 'Enter your password'
                    : null,
            suffixIcon: IconButton(
              icon: Icon(
                state.obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF94A3B8), // Slate-400
                size: AppSizes.iconM,
              ),
              onPressed: isLoading
                  ? null
                  : () => cubit.toggleObscurePassword(),
            ),
          ),

          const SizedBox(height: 20),

          // ── Remember Me + Forgot Password ───────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: isLoading
                    ? null
                    : () => cubit.toggleRememberMe(),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: state.rememberMe
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: state.rememberMe
                              ? AppColors.primary
                              : const Color(0xFFCBD5E1), // Slate-300
                          width: 1.5,
                        ),
                      ),
                      child: state.rememberMe
                          ? const Icon(Icons.check,
                              color: AppColors.textWhite,
                              size: 14)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remember Me',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B), // Slate-500
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
          ),

          const SizedBox(height: 32),

          // ── Sign In Button ──────────────────────────────────────
          SignInButton(
            isLoading: isLoading,
            onPressed: () => cubit.signIn(),
          ),

          const SizedBox(height: 24),

          // ── Sign Up Link ────────────────────────────────────────
          Center(
            child: RichText(
              text: TextSpan(
                text: "Don't have an account ? ",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF64748B), // Slate-500
                ),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {},
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
