// lib/features/home/presentation/cubit/home_state.dart
class HomeState {
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}