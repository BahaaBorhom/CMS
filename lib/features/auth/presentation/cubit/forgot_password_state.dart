// lib/features/auth/presentation/cubit/forgot_password_state.dart
class ForgotPasswordState {
  final String password;
  final String confirmPassword;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isValid;
  final bool isLoading;
  final bool shouldNavigateToOtp;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const ForgotPasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.passwordError,
    this.confirmPasswordError,
    this.isValid = false,
    this.isLoading = false,
    this.shouldNavigateToOtp = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  ForgotPasswordState copyWith({
    String? password,
    String? confirmPassword,
    String? passwordError,
    String? confirmPasswordError,
    bool? isValid,
    bool? isLoading,
    bool? shouldNavigateToOtp,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return ForgotPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      shouldNavigateToOtp: shouldNavigateToOtp ?? this.shouldNavigateToOtp,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? 
          this.isConfirmPasswordVisible,
    );
  }
}