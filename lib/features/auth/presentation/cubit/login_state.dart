// lib/features/auth/presentation/cubit/login_state.dart
class LoginState {
  final String phoneNumber;
  final String? phoneError;
  final bool isValid;
  final bool isLoading;

  const LoginState({
    this.phoneNumber = '',
    this.phoneError,
    this.isValid = false,
    this.isLoading = false,
  });

  LoginState copyWith({
    String? phoneNumber,
    String? phoneError,
    bool? isValid,
    bool? isLoading,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneError: phoneError,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}