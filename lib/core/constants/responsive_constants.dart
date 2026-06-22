import 'package:flutter/material.dart';

class ResponsiveConstants {
  final bool isSmallScreen;
  final double topSpacing;
  final double betweenTitleAndSub;
  final double betweenSubAndOtp;
  final double betweenLogoAndWelcome;
  final double betweenWelcomeAndField;

  const ResponsiveConstants({
    required this.isSmallScreen,
    required this.topSpacing,
    required this.betweenTitleAndSub,
    required this.betweenSubAndOtp,
    required this.betweenLogoAndWelcome,
    required this.betweenWelcomeAndField,
  });

  // Factory to create instance from screen height
  factory ResponsiveConstants.fromHeight(double height) {
    final isSmall = height < 700;
    return ResponsiveConstants(
      isSmallScreen: isSmall,
      topSpacing: isSmall ? 24 : 44,
      betweenTitleAndSub: isSmall ? 8 : 12,
      betweenSubAndOtp: isSmall ? 24 : 36,
      betweenLogoAndWelcome: isSmall ? 8 : 16,
      betweenWelcomeAndField: isSmall ? 24 : 44,
    );
  }

  // Factory to create instance from BuildContext
  factory ResponsiveConstants.fromContext(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ResponsiveConstants.fromHeight(height);
  }
}
