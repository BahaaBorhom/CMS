import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());

  void onNameChanged(String value) {
    emit(state.copyWith(
      fullName: value,
      isValid: value.trim().isNotEmpty && state.phoneNumber.trim().isNotEmpty,
    ));
  }

  void onPhoneChanged(String value) {
    emit(state.copyWith(
      phoneNumber: value,
      isValid: state.fullName.trim().isNotEmpty && value.trim().isNotEmpty,
    ));
  }

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      emit(state.copyWith(profileImage: File(pickedFile.path)));
    }
  }

  Future<void> saveProfile() async {
    if (!state.isValid) return;
    emit(state.copyWith(isLoading: true));
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
    // Navigate back or show success
  }
}