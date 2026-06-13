part of 'sign_in_cubit.dart';

/// States for the sign-in flow.
abstract class SignInState extends Equatable {
  const SignInState({
    this.obscurePassword = true,
    this.rememberMe = true,
  });

  final bool obscurePassword;
  final bool rememberMe;

  @override
  List<Object?> get props => [obscurePassword, rememberMe];
}

/// Initial state — form is idle.
class SignInInitial extends SignInState {
  const SignInInitial({
    super.obscurePassword = true,
    super.rememberMe = true,
  });
}

/// Loading — sign-in API call in progress.
class SignInLoading extends SignInState {
  const SignInLoading({
    super.obscurePassword = true,
    super.rememberMe = true,
  });
}

/// Success — user authenticated.
class SignInSuccess extends SignInState {
  const SignInSuccess(
    this.user, {
    super.obscurePassword = true,
    super.rememberMe = true,
  });

  final UserEntity user;

  @override
  List<Object?> get props => [user, obscurePassword, rememberMe];
}

/// Error — sign-in failed with a message.
class SignInError extends SignInState {
  const SignInError(
    this.message, {
    super.obscurePassword = true,
    super.rememberMe = true,
  });

  final String message;

  @override
  List<Object?> get props => [message, obscurePassword, rememberMe];
}
