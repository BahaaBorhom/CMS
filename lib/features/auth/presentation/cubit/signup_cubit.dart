// lib/features/auth/presentation/cubit/signup_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState());

  void onNameChanged(String value) {
    final error = _validateName(value);
    emit(
      state.copyWith(
        fullName: value,
        nameError: error,
        isValid: _allValid(
          value,
          state.gender,
          state.dateOfBirth,
          state.phoneNumber,
        ),
      ),
    );
  }

  void onGenderChanged(String value) {
    final error = value.isEmpty ? 'Please select your gender' : null;
    emit(
      state.copyWith(
        gender: value,
        genderError: error,
        isValid: _allValid(
          state.fullName,
          value,
          state.dateOfBirth,
          state.phoneNumber,
        ),
      ),
    );
  }

  void onDateOfBirthChanged(DateTime date) {
    emit(
      state.copyWith(
        dateOfBirth: date,
        dobError: null,
        isValid: _allValid(
          state.fullName,
          state.gender,
          date,
          state.phoneNumber,
        ),
      ),
    );
  }

  // ✅ Clear date without showing error
  void clearDateOfBirth() {
    emit(
      state.copyWith(
        dateOfBirth: null,
        dobError: null,
        isValid: _allValid(
          state.fullName,
          state.gender,
          null,
          state.phoneNumber,
        ),
      ),
    );
  }

  void onPhoneChanged(String value) {
    final raw = value.replaceAll(RegExp(r'[^0-9]'), '');
    final error = _validatePhone(raw);
    emit(
      state.copyWith(
        phoneNumber: value,
        phoneError: error,
        isPhoneValid: error == null && raw.isNotEmpty,
        isValid: _allValid(
          state.fullName,
          state.gender,
          state.dateOfBirth,
          value,
        ),
      ),
    );
  }

  bool _allValid(String name, String gender, DateTime? dob, String phone) {
    return _validateName(name) == null &&
        gender.isNotEmpty &&
        dob != null &&
        _validatePhone(phone) == null;
  }

  String? _validateName(String value) {
    if (value.isEmpty) return 'Full name is required';
    if (value.length < 2) return 'Name is too short';
    return null;
  }

  String? _validatePhone(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return 'Phone number is required';
    if (!cleaned.startsWith('09')) return 'Must start with 09';
    if (cleaned.length != 10) return 'Must be exactly 10 digits';
    return null;
  }

  void submitSignup() {
    if (state.isValid) {
      emit(state.copyWith(isLoading: true));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(isLoading: false));
        // Navigate to OTP verification
      });
    }
  }
}
