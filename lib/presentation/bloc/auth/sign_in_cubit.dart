import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/api_endpoint.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/entities/user_entity.dart';

part 'sign_in_state.dart';

/// Cubit that drives the Sign In screen as a pure controller.
///
/// Keeps form state and controllers inside the Cubit to support a stateless view.
/// Calls ApiServices directly, matching the reference LoginController.
class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInInitial());

  // ── Form State & Controllers ──────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController(text: "client@gmail.com");
  final passwordCtrl = TextEditingController(text: "1234");

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

  /// Attempts sign-in using controllers by calling API directly.
  Future<void> signIn() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (state is SignInLoading) return;

    emit(SignInLoading(
      obscurePassword: state.obscurePassword,
      rememberMe: state.rememberMe,
    ));

    // Add a small delay for realistic UX feel
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final response = await ApiServices.post<UserModel>(
        UserModel.fromJson,
        ApiEndpoint.login,
        body: {
          'email': usernameCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
        },
        showSuccessMessage: true,
        isBasic: true,
      );

      if (response != null) {
        // Save user info and token locally
        await LocalStorage.saveToken(token: response.token);
        await LocalStorage.saveUserJson(json: json.encode(response.toJson()));

        emit(SignInSuccess(
          response.toEntity(),
          obscurePassword: state.obscurePassword,
          rememberMe: state.rememberMe,
        ));
      } else {
        emit(SignInError(
          'Invalid username or password.',
          obscurePassword: state.obscurePassword,
          rememberMe: state.rememberMe,
        ));
      }
    } catch (e) {
      emit(SignInError(
        e.toString(),
        obscurePassword: state.obscurePassword,
        rememberMe: state.rememberMe,
      ));
    }
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
