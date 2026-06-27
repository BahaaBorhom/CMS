// lib/features/home/presentation/cubit/home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true));

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy data – replace later with real entities
    emit(
      state.copyWith(
        isLoading: false,
        appointments: [
          // 'Dr. Folan Al-Folani (Heart) – Follow up visit – Some clinic – 7/7/2026 9:15 AM',
          // 'Dr. Folan Al-Folani (Heart) – Follow up visit – Some clinic – 7/7/2026 9:15 AM',
          // 'Dr. Folan Al-Folani (Heart) – Follow up visit – Some clinic – 7/7/2026 9:15 AM',
          // 'Dr. Folan Al-Folani (Heart) – Follow up visit – Some clinic – 7/7/2026 9:15 AM',
        ],
        alerts: [
          // '5 minutes ago – You\'re late for your appointment',
          // '1 hour ago – Your next appointment is in 2 hours',
        ],
        clinics: [
          // 'Some name clinic – Dentist – Damascus, Al-Mazzeh – 9:00 AM - 5:00 PM',
          // 'Some name clinic – Dentist – Damascus, Al-Mazzeh – 9:30 AM - 5:00 PM',
        ],
        history: [
          // {
          //   'clinic': 'Some name clinic (Dentist)',
          //   'location': 'Damascus, Al-Mazzeh',
          //   'time': '3 months ago',
          // },
          // {
          //   'clinic': 'Some name clinic (Dentist)',
          //   'location': 'Damascus, Al-Mazzeh',
          //   'time': '3 weeks ago',
          // },
        ],
      ),
    );
  }
}
