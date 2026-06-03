import 'package:cms/core/widgets/splash_screen.dart';
import 'package:cms/features/auth/presentation/screens/auth_screen.dart';
import 'package:cms/features/auth/presentation/screens/on_bording_screen.dart';
import 'package:cms/features/auth/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/welcome': (context) => const WelcomeScreen(),
      '/auth': (context) => const AuthScreen(),
      '/onboarding': (context) => const OnBordingScreen(),
    },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}
