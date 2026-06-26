import 'package:cms/core/widgets/splash_screen.dart';
// import 'package:cms/features/auth/presentation/screens/auth_screen.dart';
// import 'package:cms/features/auth/presentation/screens/forgot_password_screen.dart';
// import 'package:cms/features/auth/presentation/screens/home_screen.dart';
// import 'package:cms/features/auth/presentation/screens/login_screen.dart';
// import 'package:cms/features/auth/presentation/screens/on_bording_screen.dart';
// import 'package:cms/features/auth/presentation/screens/signup_screen.dart';
// import 'package:cms/features/auth/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cms/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   '/welcome': (context) => const WelcomeScreen(),
      //   '/auth': (context) => const AuthScreen(),
      //   '/onboarding': (context) => OnBordingScreen(),
      //   LoginScreen.routeName: (context) => const LoginScreen(), // ✅ Use routeName
      //   ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(), // ✅ Add this
      //   SignupScreen.routeName : (context) => const SignupScreen(), // ✅ Add this
      //   HomeScreen.routeName: (context) => const HomeScreen(),
      //   // '/otp' is NOT here – it needs a parameter (phoneNumber)
      // },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}