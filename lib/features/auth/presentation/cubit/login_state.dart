class LoginState {
  final String phoneNumber;
  final String password;          // ✅ Added
  final String? phoneError;
  final String? passwordError;    // ✅ Added
  final bool isValid;
  final bool isLoading;
  final bool shouldNavigateToOtp;
  final bool isPasswordVisible;   // ✅ Added

  const LoginState({
    this.phoneNumber = '',
    this.password = '',           // ✅ Added
    this.phoneError,
    this.passwordError,           // ✅ Added
    this.isValid = false,
    this.isLoading = false,
    this.shouldNavigateToOtp = false,
    this.isPasswordVisible = false, // ✅ Added
  });

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    String? phoneError,
    String? passwordError,
    bool? isValid,
    bool? isLoading,
    bool? shouldNavigateToOtp,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      phoneError: phoneError,
      passwordError: passwordError,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      shouldNavigateToOtp: shouldNavigateToOtp ?? this.shouldNavigateToOtp,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}