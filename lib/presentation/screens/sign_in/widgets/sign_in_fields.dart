import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../presentation/widgets/app_input_field.dart';
import '../../../bloc/auth/sign_in_cubit.dart';

class SignInFields extends StatelessWidget {
  final SignInCubit cubit;
  final SignInState state;
  final bool isLoading;

  const SignInFields({
    super.key,
    required this.cubit,
    required this.state,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppInputField(
          label: 'Username',
          hint: 'designslab',
          controller: cubit.usernameCtrl,
          keyboardType: TextInputType.text,
          enabled: !isLoading,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Enter your username' : null,
        ),
        const SizedBox(height: 20),
        AppInputField(
          label: 'Password',
          hint: 'Password',
          controller: cubit.passwordCtrl,
          obscureText: state.obscurePassword,
          enabled: !isLoading,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Enter your password' : null,
          suffixIcon: IconButton(
            icon: Icon(
              state.obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xFF94A3B8),
              size: AppSizes.iconM,
            ),
            onPressed: isLoading ? null : () => cubit.toggleObscurePassword(),
          ),
        ),
      ],
    );
  }
}
