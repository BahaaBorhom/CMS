// lib/features/auth/presentation/cubit/login_cubit.dart
import 'package:cms/features/auth/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  // ---- Phone Number ----
  void onPhoneChanged(String value) {
    final error = _validatePhoneNumber(value);
    final isValid = _validateForm(value, state.password);
    emit(
      state.copyWith(phoneNumber: value, phoneError: error, isValid: isValid),
    );
  }

  String? _validatePhoneNumber(String value) {
    if (value.isEmpty) return 'Phone number is required';
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (!cleaned.startsWith('09')) return 'Invalid phone number';
    if (cleaned.length != 10) return 'Invalid phone number';
    return null;
  }

  // ---- Password ----
  void onPasswordChanged(String value) {
    final error = _validatePassword(value);
    final isValid = _validateForm(state.phoneNumber, value);
    emit(
      state.copyWith(password: value, passwordError: error, isValid: isValid),
    );
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  // ---- Combined Validation ----
  bool _validateForm(String phone, String password) {
    final phoneError = _validatePhoneNumber(phone);
    final passwordError = _validatePassword(password);
    return phoneError == null &&
        passwordError == null &&
        phone.isNotEmpty &&
        password.isNotEmpty;
  }

  // ---- Toggle Password Visibility ----
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  // ---- Submit Login (was submitPhoneNumber) ----
  void submitLogin() {
    if (state.isValid) {
      emit(state.copyWith(isLoading: true));
      // Simulate API call (replace with real use case)
      Future.delayed(const Duration(seconds: 1), () {
        // On success – navigate to OTP or Home
        emit(state.copyWith(isLoading: false, shouldNavigateToOtp: true));
      });
    }
  }

  // ---- Reset Navigation ----
  void resetNavigation() {
    emit(state.copyWith(shouldNavigateToOtp: false));
  }

  // ---- Clear Errors ----
  void clearErrors() {
    emit(state.copyWith(phoneError: null, passwordError: null));
  }

  // ---- Forgot Password (UI will handle navigation) ----
  void forgotPassword() {
    // Just a placeholder – the UI will handle navigation
    // You can emit a state if needed, or let the UI handle it directly
  }
}
