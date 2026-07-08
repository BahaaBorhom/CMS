//lib/features/search/presentation/screens/search_screen.dart
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/search/presentation/cubit/search_cubit.dart';
import 'package:cms/features/search/presentation/cubit/search_state.dart';
import 'package:cms/features/search/presentation/cubit/searchresult_cubit.dart';
import 'package:cms/features/search/presentation/screens/searchresult_screen.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
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
      create: (context) => getIt<SearchCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.main_background_white,
        body: SafeArea(
          child: Column(
            children: [
              // ============================================================
              //  BLUE HEADER WITH BACK BUTTON + SEARCH FIELD
              // ============================================================
              _buildSearchHeader(context),
              // ============================================================
              //  BODY (Recent + Popular Searches)
              // ============================================================
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ---- Recent Searches ----
                            if (state.recentSearches.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              _buildSectionHeader(
                                title: 'Recent searches:',
                                onClear: () {
                                  context
                                      .read<SearchCubit>()
                                      .clearRecentSearches();
                                },
                              ),
                              const SizedBox(height: 8),
                              ..._buildSearchItems(
                                state.recentSearches,
                                context,
                              ),
                              const SizedBox(height: 20),
                            ],
                            // ---- Popular Searches ----
                            const SizedBox(height: 20),
                            Text(
                              'Popular searches:',
                              style: FontHeading.heading4.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ..._buildSearchItems(
                              state.popularSearches,
                              context,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
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
  //  SEARCH HEADER (Blue + Back Button + Search Field)
  // ============================================================
  Widget _buildSearchHeader(BuildContext context) {
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
      child: Row(
        children: [
          // ---- Back Button (White circle) ----
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.main_background_blue,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // ---- Search Field (Auto-focus) ----
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return TextField(
                    focusNode: _focusNode,
                    autofocus: true,
                    onChanged: (value) {
                      context.read<SearchCubit>().onQueryChanged(value);
                    },
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        context.read<SearchCubit>().addRecentSearch(
                          value.trim(),
                        );
                        final query = value.trim(); // 👈 This is your query
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) =>
                                  getIt<SearchResultsCubit>()..search(query),
                              child: SearchResultsScreen(query: query),
                            ),
                          ),
                        );
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
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  SEARCH ITEMS (Reusable)
  // ============================================================
  List<Widget> _buildSearchItems(List<String> items, BuildContext context) {
    return items.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: GestureDetector(
          onTap: () {
            context.read<SearchCubit>().addRecentSearch(item);
            final query = item; // 👈 This is your query
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => getIt<SearchResultsCubit>()..search(query),
                  child: SearchResultsScreen(query: query),
                ),
              ),
            );
          },
          child: Row(
            children: [
              Icon(Icons.search, color: AppColors.customGray, size: 16),
              const SizedBox(width: 10),
              Text(item, style: FontHeading.body.copyWith(color: Colors.black)),
              const Spacer(),
              // Small arrow (optional – for popular items)
              // Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.customGray),
            ],
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  //  SECTION HEADER (with Clear button)
  // ============================================================
  Widget _buildSectionHeader({required String title, VoidCallback? onClear}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FontHeading.heading4.copyWith(color: AppColors.customGray),
        ),
        if (onClear != null)
          GestureDetector(
            onTap: onClear,
            child: Text(
              'Clear',
              style: FontHeading.bodySmall.copyWith(
                color: AppColors.main_background_blue,
              ),
            ),
          ),
      ],
    );
  }
}
