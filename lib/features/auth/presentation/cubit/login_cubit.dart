// lib/features/auth/presentation/cubit/login_cubit.dart
import 'package:cms/features/auth/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onPhoneChanged(String value) {
    final error = _validatePhoneNumber(value);
    emit(
      state.copyWith(
        phoneNumber: value,
        phoneError: error,
        isValid: error == null && value.isNotEmpty,
      ),
    );
  }

  String? _validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (!cleaned.startsWith('09')) {
      return 'Invalid phone number';
    }

    if (cleaned.length != 10) {
      return 'Invalid phone number';
    }

    return null; // No error
  }

  void submitPhoneNumber() {
    if (state.isValid) {
      // Emit loading state
      emit(state.copyWith(isLoading: true));

      // Here you would call your use case
      // Example: authUseCase.sendOtp(state.phoneNumber)

      // For now, just simulate
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(isLoading: false));
        // Navigate to OTP screen
      });
    }
  }

  void clearError() {
    emit(state.copyWith(phoneError: null));
  }
}
