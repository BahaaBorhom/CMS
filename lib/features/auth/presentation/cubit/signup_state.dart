// lib/features/auth/presentation/cubit/signup_state.dart
import 'dart:io';

class SignupState {
  final String fullName;
  final String gender;
  final DateTime? dateOfBirth;
  final String phoneNumber;
  final String? nameError;
  final String? genderError;
  final String? dobError;
  final String? phoneError;
  final bool isValid;
  final bool isLoading;
  final bool isPhoneValid;
  final bool isGenderFocused;
  final bool isDobFocused;
  final File? profileImage; // 👈 new

  const SignupState({
    this.fullName = '',
    this.gender = '',
    this.dateOfBirth,
    this.phoneNumber = '',
    this.nameError,
    this.genderError,
    this.dobError,
    this.phoneError,
    this.isValid = false,
    this.isLoading = false,
    this.isPhoneValid = false,
    this.isGenderFocused = false,
    this.isDobFocused = false,
    this.profileImage,
  });

  SignupState copyWith({
    String? fullName,
    String? gender,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? nameError,
    String? genderError,
    String? dobError,
    String? phoneError,
    bool? isValid,
    bool? isLoading,
    bool? isPhoneValid,
    bool? isGenderFocused,
    bool? isDobFocused,
    File? profileImage,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nameError: nameError,
      genderError: genderError,
      dobError: dobError,
      phoneError: phoneError,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isGenderFocused: isGenderFocused ?? this.isGenderFocused,
      isDobFocused: isDobFocused ?? this.isDobFocused,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}