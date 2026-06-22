// lib/features/auth/presentation/screens/otp_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/constants/responsive_constants.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/auth/presentation/cubit/language_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/language_state.dart';
import 'package:cms/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/otp_state.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/otp';
  final String phoneNumber;

  const OtpScreen({super.key, this.phoneNumber = ''});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConstants.fromContext(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LanguageCubit>()),
        BlocProvider(create: (context) => getIt<OtpCubit>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ---- App Bar (same as login) ----
                          BlocBuilder<LanguageCubit, LanguageState>(
                            builder: (context, langState) {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  Text(
                                    "Back",
                                    style: FontHeading.body.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 4),
                                        DropdownButton<String>(
                                          value: langState.selectedLanguage,
                                          icon: const SizedBox(),
                                          underline: const SizedBox(),
                                          style: FontHeading.body.copyWith(
                                            color: Colors.black,
                                          ),
                                          items: langState.languages.map((
                                            String language,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: language,
                                              child: Text(language),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              context
                                                  .read<LanguageCubit>()
                                                  .changeLanguage(newValue);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    Assets.assetsImagesGlobe,
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              );
                            },
                          ),

                          SizedBox(height: responsive.topSpacing),

                          // ---- Title & Subtitle ----
                          SizedBox(height: responsive.topSpacing),
                          Container(
                            width: 92,
                            height: 92,
                            child: Image.asset(Assets.assetsImagesCrossBlue),
                          ),
                          SizedBox(height: responsive.betweenLogoAndWelcome),

                          Text(
                            "Verify your account",
                            style: FontHeading.heading1.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: responsive.betweenTitleAndSub),
                          Text(
                            "We sent a verification code\n to ${_formatPhoneNumber(phoneNumber)}",
                            style: FontHeading.bodyLarge.copyWith(
                              color: AppColors.grayDark,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: responsive.betweenSubAndOtp),

                          // ---- OTP Input (6-digit) ----
                          BlocBuilder<OtpCubit, OtpState>(
                            builder: (context, state) {
                              return _buildOtpInput(context);
                            },
                          ),

                          const SizedBox(height: 16),

                          // ---- Resend timer ----
                          BlocBuilder<OtpCubit, OtpState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Text(
                                    "Resend code in ",
                                    style: FontHeading.bodySmall.copyWith(
                                      color: AppColors.grayDark,
                                    ),
                                  ),
                                  Text(
                                    _formatTimer(state.resendTimer),
                                    style: FontHeading.bodySmall.copyWith(
                                      color: AppColors.main_background_blue,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          AppColors.main_background_blue,
                                    ),
                                  ),
                                  if (state.resendTimer == 0)
                                    TextButton(
                                      onPressed: () {
                                        context.read<OtpCubit>().resendCode();
                                      },
                                      child: Text(
                                        "Resend",
                                        style: FontHeading.bodySmall.copyWith(
                                          color: AppColors.main_background_blue,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.main_background_blue,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),

                          const Spacer(),

                          // ---- Verify Button ----
                          BlocBuilder<OtpCubit, OtpState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: state.isValid && !state.isLoading
                                      ? () =>
                                            context.read<OtpCubit>().verifyOtp()
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor: AppColors
                                        .main_background_blue
                                        .withOpacity(0.2),
                                    backgroundColor:
                                        AppColors.main_background_blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: state.isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                      : const Text(
                                          "Verify",
                                          style: FontHeading.button,
                                        ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // ---- Terms (same as login) ----
                          _buildTermsSection(),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ---- OTP input field (6 digits) ----
  Widget _buildOtpInput(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            final digit = state.otpCode.length > index
                ? state.otpCode[index]
                : '';
            return SizedBox(
              width: 48,
              height: 56,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: FontHeading.heading1.copyWith(
                  fontSize: 24,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.main_background_white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.customGray,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.main_background_blue,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                onChanged: (value) {
                  // Get current OTP code
                  String currentCode = state.otpCode;
                  List<String> chars = currentCode.split('');

                  if (value.isNotEmpty) {
                    // Typing a digit – add/replace at current position
                    if (index < chars.length) {
                      chars[index] = value;
                    } else {
                      chars.add(value);
                    }
                  } else {
                    // Deleting – remove at current position
                    if (index < chars.length) {
                      chars.removeAt(index);
                    }
                  }

                  // Update cubit with the new code
                  final updated = chars.join();
                  context.read<OtpCubit>().onOtpChanged(updated);

                  // Auto-focus next field on input
                  if (value.isNotEmpty && index < 5) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            );
          }),
        );
      },
    );
  }

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Widget _buildTermsSection() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          "By continuing, you agree to our ",
          style: FontHeading.caption.copyWith(color: AppColors.grayDark),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Terms of Service",
            style: FontHeading.caption.copyWith(
              color: AppColors.main_background_blue,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.main_background_blue,
            ),
          ),
        ),
        Text(
          " and ",
          style: FontHeading.caption.copyWith(color: AppColors.grayDark),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Privacy Policy",
            style: FontHeading.caption.copyWith(
              color: AppColors.main_background_blue,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.main_background_blue,
            ),
          ),
        ),
      ],
    );
  }
}

String _formatPhoneNumber(String phone) {
  // Remove any non-digit characters
  final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');

  // Check if it starts with 0 (Syrian format)
  if (digits.startsWith('0')) {
    // Replace leading 0 with +963
    return '+963${digits.substring(1)}';
  }

  // If it already has the country code format, just return it
  if (digits.startsWith('963')) {
    return '+$digits';
  }

  // Fallback - return as is
  return phone;
}
