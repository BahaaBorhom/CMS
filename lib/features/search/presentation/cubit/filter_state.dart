class FilterState {
  final String? location;
  final String? specialty;
  final String? rating;
  final String? sortBy;
  final bool hasChanges;

  const FilterState({
    this.location,
    this.specialty = 'All',
    this.rating = 'Any rating',
    this.sortBy = 'Popular',
    this.hasChanges = false,
  });

  FilterState copyWith({
    String? location,
    String? specialty,
    String? rating,
    String? sortBy,
    bool? hasChanges,
  }) {
    return FilterState(
      location: location ?? this.location,
      specialty: specialty ?? this.specialty,
      rating: rating ?? this.rating,
      sortBy: sortBy ?? this.sortBy,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }
}