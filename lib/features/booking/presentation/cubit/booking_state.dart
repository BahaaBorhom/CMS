// lib/features/booking/presentation/cubit/booking_state.dart
import 'package:cms/core/entities/appointment.dart';

class BookingState {
  final bool isLoading;
  final List<Appointment> allAppointments;
  final List<Appointment> filteredAppointments;
  final String selectedStatus;

  const BookingState({
    this.isLoading = false,
    this.allAppointments = const [],
    this.filteredAppointments = const [],
    this.selectedStatus = 'All',
  });

  BookingState copyWith({
    bool? isLoading,
    List<Appointment>? allAppointments,
    List<Appointment>? filteredAppointments,
    String? selectedStatus,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      allAppointments: allAppointments ?? this.allAppointments,
      filteredAppointments: filteredAppointments ?? this.filteredAppointments,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}