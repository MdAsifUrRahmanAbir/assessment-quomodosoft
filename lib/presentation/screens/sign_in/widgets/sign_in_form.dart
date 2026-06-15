import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth/sign_in_cubit.dart';
import 'sign_in_button.dart';
import 'sign_in_fields.dart';
import 'sign_in_footer.dart';
import 'sign_in_header.dart';
import 'sign_in_remember_me.dart';

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
          const SignInHeader(),
          SignInFields(
            cubit: cubit,
            state: state,
            isLoading: isLoading,
          ),
          const SizedBox(height: 20),
          SignInRememberMe(
            cubit: cubit,
            state: state,
            isLoading: isLoading,
          ),
          const SizedBox(height: 32),
          SignInButton(
            isLoading: isLoading,
            onPressed: () => cubit.signIn(),
          ),
          const SizedBox(height: 24),
          const SignInFooter(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
