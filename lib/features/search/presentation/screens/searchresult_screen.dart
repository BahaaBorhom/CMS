// lib/features/search_results/presentation/screens/search_results_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_cubit.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsScreen extends StatelessWidget {
  static const routeName = '/search-results';
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // The cubit is already provided by the parent (Navigation)
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            //  BLUE HEADER (Same as Home Screen + Search Button)
            // ============================================================
            _buildBlueHeader(context),
            // ============================================================
            //  BODY (Search Results)
            // ============================================================
            Expanded(
              child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.results.isEmpty && state.query.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 64,
                            color: AppColors.customGray,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No results found for "${state.query}"',
                            style: FontHeading.body.copyWith(
                              color: AppColors.customGray,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.results.isNotEmpty) ...[
                          Text(
                            'Search results:',
                            style: FontHeading.heading4.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              final clinic = state.results[index];
                              return _buildClinicCard(clinic);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  BLUE HEADER (Matches Home Screen)
  // ============================================================
  Widget _buildBlueHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.main_background_blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Top Row: Avatar + Name + "View my records" ----
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  Assets.assetsImagesUserFolanAlfolani,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Folan Al-Folani',
                      style: FontHeading.heading1.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'View my records',
                      style: FontHeading.bodySmall.copyWith(
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ---- Search Button (Navigates back to Search Screen) ----
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Go back to SearchScreen
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.search,
                    color: AppColors.customGray,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search clinics, doctors, specialty...',
                      style: FontHeading.body.copyWith(
                        color: AppColors.customGray,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  // Small arrow to indicate it's a button
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.customGray,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ============================================================
  //  CLINIC CARD (Matches History Card in Home Screen)
  // ============================================================
  Widget _buildClinicCard(Clinic clinic) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Photo (87 x 87) with Bookmark Icon ----
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Assets.assetsImagesClinicPlaceholder,
                  width: 87,
                  height: 87,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Icon(
                    clinic.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: clinic.isSaved
                        ? AppColors.main_background_blue
                        : AppColors.CustomgrayDark,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // ---- Text Column ----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  clinic.name,
                  style: FontHeading.body.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // ---- Location ----
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.CustomgrayDark,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        clinic.location,
                        style: FontHeading.bodySmall.copyWith(
                          color: AppColors.CustomgrayDark,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // ---- Specialty / Hours ----
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital_outlined,
                      color: AppColors.CustomgrayDark,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        clinic.specialty,
                        style: FontHeading.bodySmall.copyWith(
                          color: AppColors.CustomgrayDark,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // ---- Rating (optional) ----
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      clinic.rating.toString(),
                      style: FontHeading.bodySmall.copyWith(
                        color: AppColors.CustomgrayDark,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}