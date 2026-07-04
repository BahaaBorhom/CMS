import 'package:cms/core/entities/alert.dart';
import 'package:cms/core/entities/appointment.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/core/entities/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(milliseconds: 500));

    final appointments = [
      Appointment(
        id: '1',
        doctorName: 'Dr. Folan Al-Folani (Dintist)',
        specialty: 'Heart',
        clinicName: 'Some clinic',
        date: '7/7/2026',
        time: '9:15 AM',
        followUp: 'Follow up visit',
        status: 'Confirmed',
      ),
      Appointment(
        id: '2',
        doctorName: 'Dr. Folan Al-Folani (Heart)',
        specialty: 'Heart',
        clinicName: 'Some clinic',
        date: '7/7/2026',
        time: '9:15 AM',
        followUp: 'Follow up visit',
        status: 'Pending',
      ),
    ];

    final alerts = [
      Alert(
        id: '1',
        time: '5 minutes ago',
        message: 'You\'re late for your appointment',
        isLate: true,
      ),
      Alert(
        id: '2',
        time: '1 hour ago',
        message: 'Your next appointment is in 2 hours',
        isLate: false,
      ),
      Alert(
        id: '3',
        time: '1 day ago',
        message: 'Your next appointment is in 3 hours',
        isLate: false,
      ),
    ];

    final clinics = [
      Clinic(
        id: '1',
        name: 'Al-Mazzeh Medical Center',
        specialty: 'General Medicine',
        location: 'Damascus, Al-Mazzeh',
        hours: '9:00 AM - 5:00 PM',
        latitude: 33.5138,
        longitude: 36.2765,
        rating: 4.8,
        isSaved: true,
      ),
      Clinic(
        id: '2',
        name: 'Heart Care Clinic',
        specialty: 'Cardiology',
        location: 'Damascus, Al-Muhafaza',
        hours: '8:00 AM - 6:00 PM',
        latitude: 33.5200,
        longitude: 36.2800,
        rating: 4.5,
        isSaved: false,
      ),
      Clinic(
        id: '3',
        name: 'Al-Mazzeh Dental Center',
        specialty: 'Dentist',
        location: 'Damascus, Al-Mazzeh',
        hours: '9:30 AM - 5:00 PM',
        latitude: 33.5160,
        longitude: 36.2780,
        rating: 4.2,
        isSaved: true,
      ),
      Clinic(
        id: '4',
        name: 'Damascus Eye Hospital',
        specialty: 'Ophthalmology',
        location: 'Damascus, Al-Maliki',
        hours: '8:30 AM - 4:30 PM',
        latitude: 33.5080,
        longitude: 36.2850,
        rating: 4.6,
        isSaved: false,
      ),
    ];
    final history = [
      History(
        id: '1',
        clinicName: 'Some name clinic (Dentist)',
        location: 'Damascus, Al-Mazzeh',
        timeVisited: '3 months ago',
      ),
      History(
        id: '2',
        clinicName: 'Some name clinic (Dentist)',
        location: 'Damascus, Al-Mazzeh',
        timeVisited: '3 weeks ago',
      ),
    ];

    emit(
      state.copyWith(
        isLoading: false,
        appointments: appointments,
        alerts: alerts,
        clinics: clinics,
        history: history,
      ),
    );
  }
}
