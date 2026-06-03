import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/auth/presentation/screens/on_bording_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SizedBox(height: 200),
          Image.asset(Assets.assetsImagesCross, height: 92, width: 92),
          SizedBox(height: 32),
          Text("Project Name", style: FontHeading.heading1),
        ],
      ),
      duration: 3000,
      splashIconSize: 500,

      nextScreen: OnBordingScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: AppColors.main_background_blue,
    );
  }
}
