import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/sign_in_usecase.dart';

part 'sign_in_state.dart';

/// Cubit that drives the Sign In screen as a pure controller.
///
/// Keeps form state and controllers inside the Cubit to support a stateless view.
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signInUseCase) : super(const SignInInitial());

  final SignInUseCase _signInUseCase;

  // ── Form State & Controllers ──────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController(text: 'designslab');
  final passwordCtrl = TextEditingController();

  /// Toggles password visibility and updates states
  void toggleObscurePassword() {
    emit(SignInInitial(
      obscurePassword: !state.obscurePassword,
      rememberMe: state.rememberMe,
    ));
  }

  /// Toggles remember me checkbox and updates states
  void toggleRememberMe() {
    emit(SignInInitial(
      obscurePassword: state.obscurePassword,
      rememberMe: !state.rememberMe,
    ));
  }

  /// Attempts sign-in using controllers.
  Future<void> signIn() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (state is SignInLoading) return;

    emit(SignInLoading(
      obscurePassword: state.obscurePassword,
      rememberMe: state.rememberMe,
    ));

    // Add a small delay for realistic UX feel
    await Future.delayed(const Duration(milliseconds: 800));

    final result = await _signInUseCase(
      username: usernameCtrl.text.trim(),
      password: passwordCtrl.text.trim(),
    );

    result.fold(
      (failure) {
        // ── Demo fallback ───────────────────────────────────────────────────
        if (failure is NetworkFailure || failure is ServerFailure) {
          emit(
            SignInSuccess(
              UserEntity(
                id: '1',
                name: usernameCtrl.text.trim(),
                email: '${usernameCtrl.text.trim()}@demo.com',
                token: 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
              ),
              obscurePassword: state.obscurePassword,
              rememberMe: state.rememberMe,
            ),
          );
        } else {
          emit(SignInError(
            failure.message,
            obscurePassword: state.obscurePassword,
            rememberMe: state.rememberMe,
          ));
        }
      },
      (user) => emit(SignInSuccess(
        user,
        obscurePassword: state.obscurePassword,
        rememberMe: state.rememberMe,
      )),
    );
  }

  /// Resets state back to initial.
  void reset() => emit(SignInInitial(
        obscurePassword: state.obscurePassword,
        rememberMe: state.rememberMe,
      ));

  @override
  Future<void> close() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    return super.close();
  }
}
