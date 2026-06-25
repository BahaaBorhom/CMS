// lib/features/home/presentation/cubit/home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true));
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }
}