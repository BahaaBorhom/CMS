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
    if (value.isEmpty) return 'Phone number is required';
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (!cleaned.startsWith('09')) return 'Invalid phone number';
    if (cleaned.length != 10) return 'Invalid phone number';
    return null;
  }

  void submitPhoneNumber() {
    if (state.isValid) {
      emit(state.copyWith(isLoading: true));

      // Simulate API call (replace with real use case)
      Future.delayed(const Duration(seconds: 1), () {
        // On success – navigate to OTP
        emit(state.copyWith(
          isLoading: false,
          shouldNavigateToOtp: true, // 👈 trigger navigation
        ));
      });
    }
  }

  // Reset navigation flag after navigation is done
  void resetNavigation() {
    emit(state.copyWith(shouldNavigateToOtp: false));
  }

  void clearError() {
    emit(state.copyWith(phoneError: null));
  }
}