// lib/features/auth/presentation/cubit/otp_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart'; // ✅ import the state

class OtpCubit extends Cubit<OtpState> {
  Timer? _timer;

  OtpCubit() : super(const OtpState()) {
    print('OtpCubit created, resendTimer = ${state.resendTimer}');
    _startTimer();
  }

  void onOtpChanged(String value) {
    final raw = value.replaceAll(RegExp(r'[^0-9]'), '');
    final isValid = raw.length == 6;
    emit(state.copyWith(
      otpCode: raw,
      isValid: isValid,
      errorMessage: null,
    ));
  }

  void verifyOtp() {
    if (!state.isValid) return;
    emit(state.copyWith(isLoading: true));
    Future.delayed(const Duration(seconds: 2), () {
      // Simulate API call – replace with real logic
      emit(state.copyWith(
        isLoading: false,
        errorMessage: null, // or set error on failure
      ));
    });
  }

  void resendCode() {
    emit(state.copyWith(resendTimer: 60, errorMessage: null));
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendTimer <= 0) {
        timer.cancel();
        return;
      }
      emit(state.copyWith(resendTimer: state.resendTimer - 1));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}