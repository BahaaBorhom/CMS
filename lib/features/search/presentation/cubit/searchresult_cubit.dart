import 'package:cms/features/search/presentation/cubit/searchresult_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/core/entities/clinic.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  SearchResultsCubit() : super(const SearchResultsState());

  Future<void> search(String query) async {
    emit(state.copyWith(isLoading: true, query: query));

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Sample results – replace with real API call
    final results = [
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
    ];

    // Filter results based on query
    final filtered = results.where((clinic) =>
        clinic.name.toLowerCase().contains(query.toLowerCase()) ||
        clinic.specialty.toLowerCase().contains(query.toLowerCase()) ||
        clinic.location.toLowerCase().contains(query.toLowerCase())
    ).toList();

    emit(state.copyWith(isLoading: false, results: filtered));
  }

  void clearResults() {
    emit(state.copyWith(results: [], query: ''));
  }
}