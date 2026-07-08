import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_cubit.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_state.dart';
import 'package:cms/features/search/presentation/screens/search_screen.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsScreen extends StatefulWidget {
  static const routeName = '/search-results';
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Trigger search when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchResultsCubit>().search(widget.query);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchResultsCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.lightGray,
        body: SafeArea(
          child: Column(
            children: [
              // ============================================================
              //  BLUE HEADER (Same as Home Screen + Search Bar)
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
                          if (state.query.isNotEmpty) ...[
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
          // ---- Search Bar (Auto-focus) ----
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
              builder: (context, state) {
                return TextField(
                  focusNode: _focusNode,
                  autofocus: true,
                  controller: TextEditingController(text: state.query),
                  onChanged: (value) {
                    // Update search as user types
                    context.read<SearchResultsCubit>().search(value);
                  },
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      context.read<SearchResultsCubit>().search(value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search clinics, doctors, specialty...',
                    hintStyle: FontHeading.body.copyWith(
                      color: AppColors.customGray,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.customGray,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    suffixIcon: state.query.isNotEmpty
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              context.read<SearchResultsCubit>().clearResults();
                              // Also clear the text field
                              // We need to update the controller manually
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.customGray,
                              size: 18,
                            ),
                          )
                        : null,
                  ),
                );
              },
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
          // ---- Photo (87 x 87) ----
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              Assets.assetsImagesClinicPlaceholder,
              width: 87,
              height: 87,
              fit: BoxFit.cover,
            ),
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
                // Location
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
                // Specialty / Hours
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
                // Rating (optional)
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
          // ---- Bookmark Icon (top-right of card) ----
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              clinic.isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: clinic.isSaved
                  ? AppColors.main_background_blue
                  : AppColors.CustomgrayDark,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}