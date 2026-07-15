// lib/features/search_results/presentation/screens/search_results_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_cubit.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_state.dart';
import 'package:cms/features/search/presentation/screens/filter_screen.dart';
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
            const SizedBox(height: 12),
            _buildSearchBar(context),
            // ============================================================
            //  BODY (Search Results)
            // ============================================================
            Expanded(
              child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
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
  //  BLUE HEADER (unchanged)
  // ============================================================
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
        padding: const EdgeInsets.fromLTRB(20, 30, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: AppColors.main_background_white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushNamed(context, NotificationsScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.main_background_blue,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---- Search Button (Navigates back to Search Screen) ----
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RepaintBoundary(
        child: Row(
          children: [
            // ---- Search Button (looks like a search bar) ----
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Navigate back to the search screen
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.main_background_white,
                    borderRadius: BorderRadius.circular(53),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Icon(Icons.search, color: AppColors.black, size: 24),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Search clinics, doctors...',
                          style: FontHeading.bodySmall.copyWith(
                            color: AppColors.customGray,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // ---- Filter Button ----
            Container(
              decoration: BoxDecoration(
                color: AppColors.main_background_blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.filter_list,
                  color: AppColors.main_background_white,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicCard(Clinic clinic) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Photo (87 x 87) with Bookmark + Rating Badge ----
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
              // ---- Bookmark Icon (Top Left) ----
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Icon(
                    Icons.bookmark,
                    color: clinic.isSaved
                        ? AppColors.main_background_blue
                        : AppColors.CustomgrayDark,
                    size: 16,
                  ),
                ),
              ),
              // ---- Rating Badge (Bottom Right) ----
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(117),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        clinic.rating.toString(),
                        style: FontHeading.caption.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.star, color: Colors.yellow.shade600, size: 16),
                    ],
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
                    fontSize: 20,
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
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // ---- Opening Hours (replaces specialty) ----
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: AppColors.CustomgrayDark,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        clinic.hours,
                        style: FontHeading.bodySmall.copyWith(
                          color: AppColors.CustomgrayDark,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
