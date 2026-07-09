import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/search/presentation/cubit/filter_cubit.dart';
import 'package:cms/features/search/presentation/cubit/filter_state.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = '/filter';

  const FilterScreen({super.key});

  final List<String> _specialties = const [
    'All',
    'Dentist',
    'Heart',
    'Something',
  ];

  final List<String> _ratings = const [
    'Any rating',
    '4.5+',
    '4.0+',
    '3.5+',
    '3.0+',
  ];

  final List<String> _sortOptions = const [
    'Popular',
    'Nearest',
    'Rating',
    'Something',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FilterCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ---- App Bar ----
              _buildBlueHeader(context),
              // ---- Body ----
              Expanded(
                child: BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          // ---- Location ----
                          _buildLocationSection(context, state),
                          const SizedBox(height: 24),
                          // ---- Specialty ----
                          _buildSpecialtySection(context, state),
                          const SizedBox(height: 24),
                          // ---- Rating ----
                          _buildRatingSection(context, state),
                          const SizedBox(height: 24),
                          // ---- Sorted By ----
                          _buildSortSection(context, state),
                          const SizedBox(height: 40),
                          // ---- Buttons ----
                          _buildButtons(context),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlueHeader(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.main_background_blue,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 30, 170, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.main_background_white,
                      borderRadius: BorderRadius.circular(117),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: AppColors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Back',
                          style: FontHeading.bodySmall.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Center(child: Text('Filters', style: FontHeading.heading4)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  LOCATION SECTION
  // ============================================================
  Widget _buildLocationSection(BuildContext context, FilterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: state.location,
            isExpanded: true,
            hint: Text(
              'Choose your Location',
              style: FontHeading.body.copyWith(color: AppColors.customGray),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            icon: Icon(Icons.arrow_drop_down, color: AppColors.customGray),
            items: const [
              DropdownMenuItem(value: 'Damascus', child: Text('Damascus')),
              DropdownMenuItem(value: 'Aleppo', child: Text('Aleppo')),
              DropdownMenuItem(value: 'Homs', child: Text('Homs')),
              DropdownMenuItem(value: 'Latakia', child: Text('Latakia')),
            ],
            onChanged: (value) {
              if (value != null) {
                context.read<FilterCubit>().setLocation(value);
              }
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  SPECIALTY SECTION
  // ============================================================
  Widget _buildSpecialtySection(BuildContext context, FilterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialty',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _specialties.map((specialty) {
            final bool isSelected = state.specialty == specialty;
            return GestureDetector(
              onTap: () {
                context.read<FilterCubit>().setSpecialty(specialty);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.main_background_blue
                      : AppColors.lightGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  specialty,
                  style: FontHeading.bodySmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ============================================================
  //  RATING SECTION
  // ============================================================
  Widget _buildRatingSection(BuildContext context, FilterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: state.rating,
            isExpanded: true,
            hint: Text(
              'Any rating',
              style: FontHeading.body.copyWith(color: AppColors.customGray),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            icon: Icon(Icons.arrow_drop_down, color: AppColors.customGray),
            items: _ratings.map((rating) {
              return DropdownMenuItem(
                value: rating,
                child: Row(
                  children: [
                    if (rating != 'Any rating') ...[
                      Icon(Icons.star, color: Colors.yellow.shade600, size: 16),
                      const SizedBox(width: 4),
                    ],
                    Text(rating),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                context.read<FilterCubit>().setRating(value);
              }
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  SORTED BY SECTION
  // ============================================================
  Widget _buildSortSection(BuildContext context, FilterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sorted by',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sortOptions.map((option) {
            final bool isSelected = state.sortBy == option;
            return GestureDetector(
              onTap: () {
                context.read<FilterCubit>().setSortBy(option);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.main_background_blue
                      : AppColors.lightGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  option,
                  style: FontHeading.bodySmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ============================================================
  //  BOTTOM BUTTONS
  // ============================================================
  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        // ---- Reset Filters ----
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.read<FilterCubit>().resetFilters();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppColors.main_background_blue.withOpacity(0.1),
              shadowColor: Colors.transparent,
            ),
            child: Text(
              'Reset filters',
              style: FontHeading.button.copyWith(
                color: AppColors.main_background_blue,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // ---- Apply ----
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Apply filters and navigate back
              context.read<FilterCubit>().applyFilters();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main_background_blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Apply',
              style: FontHeading.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
