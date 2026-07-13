import 'package:cms/core/entities/appointment.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/features/appointment/presentation/screens/appointment_detail_screen.dart';
import 'package:cms/features/auth/presentation/screens/splash_screen.dart';
import 'package:cms/features/auth/presentation/screens/login_screen.dart';
import 'package:cms/features/auth/presentation/screens/signup_screen.dart';
import 'package:cms/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:cms/features/auth/presentation/screens/otp_screen.dart';
import 'package:cms/features/auth/presentation/screens/on_bording_screen.dart';
import 'package:cms/features/auth/presentation/screens/welcome_screen.dart';
import 'package:cms/features/booking/presentation/screens/booking_screen.dart';
import 'package:cms/features/clinic/presentation/screens/clinic_detail_screen.dart';
import 'package:cms/features/home/presentation/screens/home_screen.dart';
import 'package:cms/features/map/presentation/screens/map_screen.dart';
import 'package:cms/features/map/presentation/screens/map_test_screen.dart';
import 'package:cms/features/search/presentation/screens/filter_screen.dart';
import 'package:cms/features/search/presentation/screens/search_screen.dart';
import 'package:cms/features/search/presentation/screens/searchresult_screen.dart';
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
      title: 'CMS',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/onboarding':
            return MaterialPageRoute(builder: (_) => OnBordingScreen());
          case LoginScreen.routeName:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case SignupScreen.routeName:
            return MaterialPageRoute(builder: (_) => const SignupScreen());
          case ForgotPasswordScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const ForgotPasswordScreen(),
            );
          case OtpScreen.routeName:
            final phone = settings.arguments as String? ?? '';
            return MaterialPageRoute(
              builder: (_) => OtpScreen(phoneNumber: phone),
            );
          case HomeScreen.routeName:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case AppointmentDetailScreen.routeName:
            final appointment = settings.arguments;
            return MaterialPageRoute(
              builder: (_) => AppointmentDetailScreen(
                appointment: appointment as Appointment,
              ),
            );
          case ClinicDetailScreen.routeName:
            final clinic = settings.arguments;
            return MaterialPageRoute(
              builder: (_) => ClinicDetailScreen(clinic: clinic as Clinic),
            );
          case MapTestScreen.routeName:
            final clinic = settings.arguments;
            return MaterialPageRoute(
              builder: (_) => MapTestScreen(clinic: clinic as Clinic?),
            );
          case SearchScreen.routeName:
            return MaterialPageRoute(builder: (_) => const SearchScreen());
          case SearchResultsScreen.routeName:
            final query = settings.arguments as String? ?? '';
            return MaterialPageRoute(
              builder: (context) => SearchResultsScreen(query: query),
            );
          case FilterScreen.routeName:
            return MaterialPageRoute(builder: (_) => const FilterScreen());
          case MapScreen.routeName:
            return MaterialPageRoute(builder: (_) => const MapScreen());
          case BookingScreen.routeName:
            return MaterialPageRoute(builder: (_) => const BookingScreen());
          default:
            return MaterialPageRoute(
              builder: (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
            );
        }
      },
    );
  }
}
// api key for google maps
// AIzaSyAAtJ6pmyOlyQ77q36kHpzgPjuz6XcTNPQAIzaSyAAtJ6pmyOlyQ77q36kHpzgPjuz6XcTNPQ