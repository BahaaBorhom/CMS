import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/core/widgets/custom_text_feild.dart';
import 'package:cms/features/auth/presentation/cubit/language_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/language_state.dart';
import 'package:cms/features/auth/presentation/cubit/login_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/login_state.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LanguageCubit>()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine if the screen is small
              final isSmallScreen = constraints.maxHeight < 700;

              // Responsive spacings
              final double topSpacing = isSmallScreen ? 24 : 44;
              final double betweenLogoAndWelcome = isSmallScreen ? 8 : 16;
              final double betweenWelcomeAndField = isSmallScreen ? 24 : 44;
              // final double fieldBottom = isSmallScreen ? 16 : 24;

              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // -------- Top Section --------
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 24,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
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
                                    child:
                                        BlocBuilder<
                                          LanguageCubit,
                                          LanguageState
                                        >(
                                          builder: (context, languageState) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(width: 4),
                                                DropdownButton<String>(
                                                  value: languageState
                                                      .selectedLanguage,
                                                  icon: const SizedBox(),
                                                  underline: const SizedBox(),
                                                  style: FontHeading.body
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                  items: languageState.languages
                                                      .map((String language) {
                                                        return DropdownMenuItem<
                                                          String
                                                        >(
                                                          value: language,
                                                          child: Text(language),
                                                        );
                                                      })
                                                      .toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                        if (newValue != null) {
                                                          context
                                                              .read<
                                                                LanguageCubit
                                                              >()
                                                              .changeLanguage(
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
                                  Image.asset(
                                    Assets.assetsImagesGlobe,
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                              SizedBox(height: topSpacing), // responsive
                              Container(
                                width: 92,
                                height: 92,
                                child: Image.asset(
                                  Assets.assetsImagesCrossBlue,
                                ),
                              ),
                              SizedBox(
                                height: betweenLogoAndWelcome,
                              ), // responsive
                              Text(
                                "Welcome back",
                                style: FontHeading.heading1.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Enter your phone number \n We'll send you a verification code",
                                style: FontHeading.bodyLarge.copyWith(
                                  color: AppColors.grayDark,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: betweenWelcomeAndField), // responsive
                        // -------- Phone Field --------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, loginState) {
                              return CustomTextField(
                                label: 'Phone number',
                                hint: '09XX XXXX XXX',
                                prefixIcon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                                isPhoneNumber: true, // ⭐ enable masking
                                errorText: loginState.phoneError,
                                onChanged: (value) {
                                  // value is raw digits (e.g., "0912345678")
                                  context.read<LoginCubit>().onPhoneChanged(
                                    value,
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // Spacer pushes the button and terms to the bottom
                        const Spacer(),

                        // -------- Button & Terms --------
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            width: double.infinity,
                            child: BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, loginState) {
                                return ElevatedButton(
                                  onPressed:
                                      loginState.isValid &&
                                          !loginState.isLoading
                                      ? () {
                                          context
                                              .read<LoginCubit>()
                                              .submitPhoneNumber();
                                        }
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
                                  child: loginState.isLoading
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
                                          'Send code',
                                          style: FontHeading.button,
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 32,
                            right: 32,
                            bottom: 32,
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                "By continuing, you agree to our ",
                                style: FontHeading.caption.copyWith(
                                  color: AppColors.grayDark,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to Terms of Service
                                },
                                child: Text(
                                  "Terms of Service",
                                  style: FontHeading.caption.copyWith(
                                    color: AppColors.main_background_blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        AppColors.main_background_blue,
                                  ),
                                ),
                              ),
                              Text(
                                " and ",
                                style: FontHeading.caption.copyWith(
                                  color: AppColors.grayDark,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to Privacy Policy
                                },
                                child: Text(
                                  "Privacy Policy",
                                  style: FontHeading.caption.copyWith(
                                    color: AppColors.main_background_blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        AppColors.main_background_blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
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
}
