// lib/features/home/presentation/cubit/home_state.dart
class HomeState {
  final bool isLoading;
  final String? errorMessage;
  final List<String> appointments;
  final List<String> alerts;
  final List<String> clinics;
  final List<Map<String, String>> history;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.appointments = const [],
    this.alerts = const [],
    this.clinics = const [],
    this.history = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<String>? appointments,
    List<String>? alerts,
    List<String>? clinics,
    List<Map<String, String>>? history,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      appointments: appointments ?? this.appointments,
      alerts: alerts ?? this.alerts,
      clinics: clinics ?? this.clinics,
      history: history ?? this.history,
    );
  }
}