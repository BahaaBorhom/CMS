// lib/features/home/presentation/screens/home_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/home/presentation/cubit/home_cubit.dart';
import 'package:cms/features/home/presentation/cubit/home_state.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..loadHomeData(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                // ---- Blue Header ----
                SliverToBoxAdapter(child: _buildBlueHeader(context)),
                // ---- Main Content ----
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar
                        _buildSearchBar(),
                        const SizedBox(height: 20),
                        // Upcoming Appointments
                        _buildSectionHeader(
                          title: 'Upcoming appointments',
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: 12),
                        _buildAppointmentsSlider(state.appointments),
                        const SizedBox(height: 24),

                        // Alerts
                        // _buildSectionHeader(title: 'Alerts', onSeeAll: () {}),
                        // const SizedBox(height: 12),
                        // ..._buildAlerts(state.alerts),
                        // const SizedBox(height: 24),

                        // Saved Clinics
                        _buildSectionHeader(
                          title: 'Saved clinics',
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: 12),
                        _buildClinicsSlider(state.clinics),
                        const SizedBox(height: 24),

                        // Visit History
                        _buildSectionHeader(
                          title: 'Visit history',
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: 12),
                        ..._buildHistory(state.history),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  //  BLUE HEADER
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26, // half of 52
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
                      ),
                      Text(
                        'View my records',
                        style: FontHeading.bodySmall.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.main_background_white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.main_background_blue,
                            size: 28,
                          ),
                        ),
                        // Positioned(
                        //   top: 8,
                        //   right: 8,
                        //   child: Container(
                        //     width: 10,
                        //     height: 10,
                        //     decoration: const BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        // ),
                      ],
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

  // ============================================================
  //  SEARCH BAR + FILTER BUTTON
  // ============================================================
  Widget _buildSearchBar() {
    return RepaintBoundary(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(53),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search clinics, doctors...',
                  hintStyle: FontHeading.body.copyWith(
                    color: AppColors.customGray,
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.customGray),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                // TODO: Show filter dialog or bottom sheet
                print('Filter button pressed');
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
    );
  }

  // ============================================================
  //  SECTION HEADER
  // ============================================================
  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FontHeading.heading4.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See all',
              style: FontHeading.bodySmall.copyWith(
                color: AppColors.main_background_blue,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.main_background_blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  APPOINTMENTS SLIDER (Empty State)
  // ============================================================
  Widget _buildAppointmentsSlider(List<String> appointments) {
    if (appointments.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                width: 122,
                height: 122,
                child: Image.asset(
                  Assets.assetsImagesEmptybox,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'No upcoming appointments',
                style: FontHeading.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Your appointments will appear here',
                style: FontHeading.bodySmall.copyWith(
                  color: AppColors.customGray,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final text = appointments[index];
          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(14),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services,
                  color: AppColors.main_background_blue,
                  size: 20,
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: FontHeading.body.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  //  ALERTS (Simple Bullet List)
  // ============================================================
  List<Widget> _buildAlerts(List<String> alerts) {
    if (alerts.isEmpty) {
      return [const Text('No alerts')];
    }
    return alerts.map((text) {
      return RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.circle, color: Colors.red, size: 8),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: FontHeading.bodySmall.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  //  CLINICS SLIDER (Horizontal Scroll)
  // ============================================================
  Widget _buildClinicsSlider(List<String> clinics) {
    if (clinics.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                width: 122,
                height: 122,
                child: Image.asset(
                  Assets.assetsImagesEmptybox,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'you don’t have any saved clinics',
                style: FontHeading.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'You’ll find here your saved clinics',
                style: FontHeading.bodySmall.copyWith(
                  color: AppColors.customGray,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          final text = clinics[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(14),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_hospital,
                  color: AppColors.main_background_blue,
                  size: 20,
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: FontHeading.body.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  //  HISTORY (Empty State + List)
  // ============================================================
  List<Widget> _buildHistory(List<Map<String, String>> history) {
    if (history.isEmpty) {
      return [
        RepaintBoundary(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 122,
                    height: 122,
                    child: Image.asset(
                      Assets.assetsImagesEmptybox,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'you don’t have a visit history',
                    style: FontHeading.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You’ll find here the clinics you visited recently',
                    style: FontHeading.bodySmall.copyWith(
                      color: AppColors.customGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
    }
    return history.map((item) {
      return RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_hospital, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['clinic']!,
                      style: FontHeading.body.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      item['location']!,
                      style: FontHeading.bodySmall.copyWith(
                        color: AppColors.customGray,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item['time']!,
                style: FontHeading.bodySmall.copyWith(
                  color: AppColors.customGray,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
