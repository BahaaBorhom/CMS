// lib/features/booking/presentation/cubit/booking_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/core/entities/appointment.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  // Sample appointments – replace with real data
  final List<Appointment> _sampleAppointments = [
    Appointment(
      id: '1',
      doctorName: 'Dr. Ahmad Al-Folani',
      specialty: 'Cardiology',
      clinicName: 'Heart Care Clinic',
      date: '2 / 7 / 2026',
      time: '2:00 PM',
      status: 'Confirmed',
      followUp: 'Follow-up visit',
    ),
    Appointment(
      id: '2',
      doctorName: 'Dr. Samira Al-Masri',
      specialty: 'Dentist',
      clinicName: 'Al-Mazzeh Dental Center',
      date: '3 / 7 / 2026',
      time: '9:30 AM',
      status: 'Pending',
    ),
    Appointment(
      id: '3',
      doctorName: 'Dr. Khalid Al-Hassan',
      specialty: 'Ophthalmology',
      clinicName: 'Damascus Eye Hospital',
      date: '4 / 7 / 2026',
      time: '11:00 AM',
      status: 'Confirmed',
      followUp: 'Post-op check',
    ),
    Appointment(
      id: '4',
      doctorName: 'Dr. Layla Al-Ali',
      specialty: 'Dermatology',
      clinicName: 'Skin Care Center',
      date: '5 / 7 / 2026',
      time: '3:30 PM',
      status: 'Rescheduled',
    ),
    Appointment(
      id: '5',
      doctorName: 'Dr. Majed Al-Khatib',
      specialty: 'Orthopedics',
      clinicName: 'Al-Muhafaza Orthopedic',
      date: '6 / 7 / 2026',
      time: '8:00 AM',
      status: 'Confirmed',
    ),
    Appointment(
      id: '6',
      doctorName: 'Dr. Hala Al-Shami',
      specialty: 'Pediatrics',
      clinicName: 'Damascus Pediatric Clinic',
      date: '7 / 7 / 2026',
      time: '10:00 AM',
      status: 'Cancelled',
    ),
    Appointment(
      id: '7',
      doctorName: 'Dr. Nabil Al-Hakim',
      specialty: 'General Medicine',
      clinicName: 'Al-Mazzeh Medical Center',
      date: '8 / 7 / 2026',
      time: '1:00 PM',
      status: 'Done',
    ),
  ];

  Future<void> loadAppointments() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(
      state.copyWith(
        isLoading: false,
        allAppointments: _sampleAppointments,
        filteredAppointments: _sampleAppointments,
      ),
    );
  }

  void selectStatus(String status) {
    emit(state.copyWith(selectedStatus: status));

    if (status == 'All') {
      emit(state.copyWith(filteredAppointments: state.allAppointments));
      return;
    }

    final filtered = state.allAppointments
        .where((appointment) => appointment.status == status)
        .toList();
    emit(state.copyWith(filteredAppointments: filtered));
  }
}