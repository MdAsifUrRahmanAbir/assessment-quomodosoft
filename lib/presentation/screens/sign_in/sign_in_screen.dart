import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/routes/app_routes.dart';
import '../../bloc/auth/sign_in_cubit.dart';
import '../../widgets/primary_app_bar.dart';
import 'widgets/sign_in_form.dart';

/// Screen 01 – Sign In (BLoC-driven, Stateless)
///
/// Uses [BlocProvider] to create a fresh [SignInCubit] from get_it.
/// [BlocConsumer] handles success/error events, while [SignInForm] is called in the body.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => sl<SignInCubit>(),
      child: const _SignInView(),
    );
  }
}

class _SignInView extends StatelessWidget {
  const _SignInView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        } else if (state is SignInError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        state.message,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: AppSizes.fontM,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: AppColors.danger,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state is SignInLoading;

        return Scaffold(
          backgroundColor: AppColors.scaffold,
          appBar: const PrimaryAppBar(title: 'Sign In'),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingL),
              child: SignInForm(
                isLoading: isLoading,
                state: state,
              ),
            ),
          ),
        );
      },
    );
  }
}
