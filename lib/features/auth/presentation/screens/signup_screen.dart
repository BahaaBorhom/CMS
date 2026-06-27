// lib/features/auth/presentation/screens/signup_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/constants/responsive_constants.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/core/widgets/custom_text_feild.dart';
import 'package:cms/features/auth/presentation/cubit/language_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/language_state.dart';
import 'package:cms/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/signup_state.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConstants.fromContext(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LanguageCubit>()),
        BlocProvider(create: (context) => getIt<SignupCubit>()),
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
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 24.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTopSection(context, responsive),

                          // -------- Single BlocBuilder for All Fields --------
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  // Full Name
                                  _buildFullNameField(state),
                                  // Gender
                                  _buildGenderField(state),
                                  // Date of Birth
                                  _buildDobField(context, state),
                                  // Phone Number
                                  _buildPhoneField(state),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 8),
                          const Spacer(),

                          // Button (separate BlocBuilder – only rebuilds when isValid or isLoading changes)
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return _buildSubmitButton(state);
                            },
                          ),

                          // Terms
                          _buildTermsSection(),
                          const SizedBox(height: 16),
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

  // ============================================================
  //  FULL NAME FIELD
  // ============================================================
  Widget _buildFullNameField(SignupState state) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRequiredLabel('Full Name'),
            const SizedBox(height: 8),
            CustomTextField(
              label: '',
              hint: 'Enter your full name',
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.name,
              errorText: state.nameError,
              onChanged: (value) {
                // context.read<SignupCubit>().onNameChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  GENDER FIELD
  // ============================================================
  Widget _buildGenderField(SignupState state) {
    final bool hasError = state.genderError != null;

    Color borderColor;
    double borderWidth;

    if (hasError) {
      borderColor = Colors.red;
      borderWidth = 2;
    } else {
      borderColor = AppColors.customGray;
      borderWidth = 1;
    }

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRequiredLabel('Gender'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: state.gender.isEmpty ? null : state.gender,
                isExpanded: true,
                hint: Text(
                  'Choose your gender',
                  style: FontHeading.body.copyWith(color: AppColors.customGray),
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.customGray,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                ),
                style: FontHeading.body.copyWith(color: Colors.black),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: hasError ? Colors.red : AppColors.customGray,
                ),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    // context.read<SignupCubit>().onGenderChanged(value);
                  }
                },
              ),
            ),
            if (state.genderError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16),
                child: Text(
                  state.genderError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  DATE OF BIRTH FIELD
  // ============================================================
  Widget _buildDobField(BuildContext context, SignupState state) {
    final bool hasError = state.dobError != null;
    final bool hasValue = state.dateOfBirth != null;

    Color borderColor;
    double borderWidth;

    if (hasError) {
      borderColor = Colors.red;
      borderWidth = 2;
    } else {
      borderColor = AppColors.customGray;
      borderWidth = 1;
    }

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRequiredLabel('Date of birth'),
            const SizedBox(height: 8),
            Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Left Calendar Icon (decorative)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: hasError ? Colors.red : AppColors.customGray,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Date Text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        state.dateOfBirth != null
                            ? '${state.dateOfBirth!.day.toString().padLeft(2, '0')}/${state.dateOfBirth!.month.toString().padLeft(2, '0')}/${state.dateOfBirth!.year}'
                            : 'DD/MM/YYYY',
                        style: FontHeading.body.copyWith(
                          color: hasValue ? Colors.black : AppColors.customGray,
                        ),
                      ),
                    ),
                  ),
                  // Clear Button
                  if (state.dateOfBirth != null)
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.customGray,
                        size: 18,
                      ),
                      onPressed: () {
                        // context.read<SignupCubit>().clearDateOfBirth();
                      },
                    ),
                  // Right Calendar Icon (clickable)
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(
                          const Duration(days: 365 * 18),
                        ),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        // context.read<SignupCubit>().onDateOfBirthChanged(picked);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.dobError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16),
                child: Text(
                  state.dobError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  PHONE NUMBER FIELD
  // ============================================================
  Widget _buildPhoneField(SignupState state) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRequiredLabel('Phone number'),
            const SizedBox(height: 8),
            CustomTextField(
              label: '',
              hint: '09XX XXXX XXX',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              isPhoneNumber: true,
              errorText: state.phoneError,
              onChanged: (value) {
                // context.read<SignupCubit>().onPhoneChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  SUBMIT BUTTON
  // ============================================================
  Widget _buildSubmitButton(SignupState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 24, 14, 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.isValid && !state.isLoading
              ? () {
                  // context.read<SignupCubit>().submitSignup();
                }
              : null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.main_background_blue.withOpacity(
              0.2,
            ),
            backgroundColor: AppColors.main_background_blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Send verification code', style: FontHeading.button),
        ),
      ),
    );
  }

  // ============================================================
  //  TOP SECTION
  // ============================================================
  Widget _buildTopSection(
    BuildContext context,
    ResponsiveConstants responsive,
  ) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildAppBar(context),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Create new account",
                style: FontHeading.heading2.copyWith(color: AppColors.black),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                "We just need some information",
                style: FontHeading.bodyLarge.copyWith(
                  color: AppColors.grayDark,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.customGray,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.main_background_blue,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "(Optional)",
                      style: FontHeading.bodyLarge.copyWith(
                        color: AppColors.customGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  APP BAR
  // ============================================================
  Widget _buildAppBar(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            Text("Back", style: FontHeading.body.copyWith(color: Colors.black)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocBuilder<LanguageCubit, LanguageState>(
                builder: (context, languageState) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                      const SizedBox(width: 4),
                      DropdownButton<String>(
                        value: languageState.selectedLanguage,
                        icon: const SizedBox(),
                        underline: const SizedBox(),
                        style: FontHeading.body.copyWith(color: Colors.black),
                        items: languageState.languages.map((String language) {
                          return DropdownMenuItem<String>(
                            value: language,
                            child: Text(language),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            context.read<LanguageCubit>().changeLanguage(
                              newValue,
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(Assets.assetsImagesGlobe, height: 24, width: 24),
          ],
        );
      },
    );
  }

  // ============================================================
  //  TERMS SECTION
  // ============================================================
  Widget _buildTermsSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 0),
      child: Wrap(
        alignment: WrapAlignment.start,
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
      ),
    );
  }
}

// ============================================================
//  HELPER – Required Label with Red Asterisk
// ============================================================
Widget _buildRequiredLabel(String text) {
  return RichText(
    text: TextSpan(
      text: text,
      style: FontHeading.bodySmall.copyWith(color: AppColors.grayDark),
      children: [
        const TextSpan(
          text: ' *',
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
}
