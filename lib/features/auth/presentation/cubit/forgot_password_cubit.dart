// lib/features/auth/presentation/cubit/forgot_password_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  void onPasswordChanged(String value) {
    final error = _validatePassword(value);
    final isValid = _validateForm(value, state.confirmPassword);
    emit(
      state.copyWith(password: value, passwordError: error, isValid: isValid),
    );
  }

  void onConfirmPasswordChanged(String value) {
    final error = _validateConfirmPassword(state.password, value);
    final isValid = _validateForm(state.password, value);
    emit(
      state.copyWith(
        confirmPassword: value,
        confirmPasswordError: error,
        isValid: isValid,
      ),
    );
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String password, String confirm) {
    if (confirm.isEmpty) return 'Please confirm your password';
    if (password != confirm) return 'Passwords do not match';
    return null;
  }

  bool _validateForm(String password, String confirm) {
    final passwordError = _validatePassword(password);
    final confirmError = _validateConfirmPassword(password, confirm);
    return passwordError == null &&
        confirmError == null &&
        password.isNotEmpty &&
        confirm.isNotEmpty;
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void submitNewPassword() {
    if (state.isValid) {
      emit(state.copyWith(isLoading: true));

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(isLoading: false, shouldNavigateToOtp: true));
      });
    }
  }

  void resetNavigation() {
    emit(state.copyWith(shouldNavigateToOtp: false));
  }

  void clearErrors() {
    emit(state.copyWith(passwordError: null, confirmPasswordError: null));
  }
}
