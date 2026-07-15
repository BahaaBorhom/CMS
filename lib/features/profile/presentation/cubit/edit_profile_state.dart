import 'dart:io';

class EditProfileState {
  final String fullName;
  final String phoneNumber;
  final File? profileImage;
  final bool isLoading;
  final bool isValid;

  const EditProfileState({
    this.fullName = 'Folan Al-Folani',
    this.phoneNumber = '0900 000 000',
    this.profileImage,
    this.isLoading = false,
    this.isValid = true,
  });

  EditProfileState copyWith({
    String? fullName,
    String? phoneNumber,
    File? profileImage,
    bool? isLoading,
    bool? isValid,
  }) {
    return EditProfileState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
    );
  }
}