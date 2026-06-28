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
        backgroundColor: AppColors.main_background_white,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildBlueHeader(context)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(),
                        const SizedBox(height: 20),

                        if (state.appointments.isNotEmpty) ...[
                          _buildSectionHeader(
                            title: 'Upcoming appointments',
                            onSeeAll: () {},
                          ),
                          const SizedBox(height: 12),
                          _buildAppointmentsSlider(state.appointments),
                          const SizedBox(height: 24),
                        ],

                        if (state.alerts.isNotEmpty) ...[
                          _buildSectionHeader(title: 'Alerts', onSeeAll: () {}),
                          const SizedBox(height: 12),
                          ..._buildAlerts(state.alerts),
                          const SizedBox(height: 24),
                        ],

                        _buildSectionHeaderWithIcon(
                          title: 'Saved clinics',
                          onSeeAll: () {},
                          icon: Icons.bookmark,
                        ),
                        const SizedBox(height: 12),
                        _buildClinicsSlider(state.clinics),
                        const SizedBox(height: 24),

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
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.main_background_white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: AppColors.main_background_blue,
                        size: 28,
                      ),
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
            style: FontHeading.heading4.copyWith(color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  SECTION HEADER WITH ICON (for Saved Clinics)
  // ============================================================
  Widget _buildSectionHeaderWithIcon({
    required String title,
    required VoidCallback onSeeAll,
    required IconData icon,
  }) {
    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: FontHeading.heading4.copyWith(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  APPOINTMENTS SLIDER – Avatar + Text + Date/Time Row
  // ============================================================
  Widget _buildAppointmentsSlider(List<String> appointments) {
    if (appointments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.calendar_today_outlined,
        title: 'No upcoming appointments',
        subtitle: 'Your appointments will appear here',
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final text = appointments[index];
          final parts = text.split(' – ');
          final doctorName = parts.isNotEmpty ? parts[0] : '';
          final followUp = parts.length > 1 ? parts[1] : '';
          final dateTime = parts.length > 3 ? parts[3] : '';
          final dateTimeParts = dateTime.split(' ');
          final date = dateTimeParts.isNotEmpty ? dateTimeParts[0] : '';
          final time = dateTimeParts.length > 1
              ? dateTimeParts.sublist(1).join(' ')
              : '';

          return RepaintBoundary(
            child: Container(
              width: 340,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.main_background_blue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          Assets.assetsImagesDoctorFolanAlfolani,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorName,
                              style: FontHeading.heading4.copyWith(
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              followUp,
                              style: FontHeading.bodySmall.copyWith(
                                color: AppColors.customGray,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: FontHeading.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 20,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: FontHeading.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(width: 83),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  //  ALERTS – Using AppColors
  // ============================================================
  List<Widget> _buildAlerts(List<String> alerts) {
    if (alerts.isEmpty) {
      return [
        RepaintBoundary(
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
                Icon(
                  Icons.notifications_off_outlined,
                  size: 48,
                  color: AppColors.customGray,
                ),
                const SizedBox(height: 12),
                Text(
                  'No alerts',
                  style: FontHeading.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'You\'re all caught up!',
                  style: FontHeading.bodySmall.copyWith(
                    color: AppColors.customGray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return alerts.map((text) {
      final parts = text.split(' – ');
      final time = parts.isNotEmpty ? parts[0] : '';
      final message = parts.length > 1 ? parts[1] : '';

      final bool isLate = message.toLowerCase().contains('late');

      final Color bgColor = isLate
          ? AppColors.alertRedBackground
          : AppColors.alertYellowBackground;

      final Color iconColor = isLate
          ? Colors.red.shade400
          : Colors.orange.shade400;

      final Color bigTextColor = isLate
          ? AppColors.alertRedBigText
          : AppColors.alertYellowBigText;

      final Color smallTextColor = isLate
          ? AppColors.alertRedSmallText
          : AppColors.alertYellowSmallText;

      return RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Icon(Icons.access_time_rounded, color: iconColor, size: 28),
                  if (isLate)
                    Positioned(
                      bottom: -1,
                      right: -2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: AppColors.alertRedBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '!',
                            style: TextStyle(
                              color: iconColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: FontHeading.caption.copyWith(
                        color: smallTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: FontHeading.bodySmall.copyWith(
                        color: bigTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: smallTextColor),
            ],
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  //  CLINICS SLIDER – Full Card Design
  // ============================================================
  Widget _buildClinicsSlider(List<String> clinics) {
    if (clinics.isEmpty) {
      return _buildEmptyState(
        image: Assets.assetsImagesEmptybox,
        title: 'you don’t have any saved clinics',
        subtitle: 'You’ll find here your saved clinics',
      );
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          final text = clinics[index];
          final parts = text.split(' – ');
          final name = parts.isNotEmpty ? parts[0] : 'Clinic Name';
          final specialty = parts.length > 1 ? parts[1] : 'Specialty';
          final location = parts.length > 2 ? parts[2] : 'Location';
          final hours = parts.length > 3 ? parts[3] : '9:00 - 5:00';

          final bool isSaved = index % 2 == 0;

          return RepaintBoundary(
            child: Container(
              width: 215,
              margin: const EdgeInsets.only(right: 12),
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
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: Image.asset(
                          Assets.assetsImagesClinicPlaceholder,
                          width: 215,
                          height: 135,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Icon(
                            Icons.bookmark,
                            color: isSaved
                                ? AppColors.main_background_blue
                                : AppColors.CustomgrayDark,
                            size: 19,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.main_background_white,
                            borderRadius: BorderRadius.circular(117),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '4.5',
                                style: FontHeading.caption.copyWith(
                                  color: AppColors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade600,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.main_background_white,
                            borderRadius: BorderRadius.circular(117),
                          ),
                          child: Text(
                            specialty,
                            style: FontHeading.caption.copyWith(
                              color: AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                    child: Text(
                      name,
                      style: FontHeading.body.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.CustomgrayDark,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: AppColors.CustomgrayDark,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hours,
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  //  HISTORY – Full Card Design (Matches Clinics)
  // ============================================================
  List<Widget> _buildHistory(List<Map<String, String>> history) {
    if (history.isEmpty) {
      return [
        RepaintBoundary(
          child: _buildEmptyState(
            image: Assets.assetsImagesEmptybox,
            title: 'you don’t have a visit history',
            subtitle: 'You’ll find here the clinics you visited recently',
          ),
        ),
      ];
    }

    return history.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      final clinicName = item['clinic'] ?? 'Clinic Name';
      final location = item['location'] ?? 'Location';
      final time = item['time'] ?? 'Time';

      final bool isSaved = index % 2 == 0;

      return RepaintBoundary(
        child: Container(
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
                        Icons.bookmark,
                        color: isSaved
                            ? AppColors.main_background_blue
                            : AppColors.CustomgrayDark,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      clinicName,
                      style: FontHeading.body.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
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
                            location,
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
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: AppColors.CustomgrayDark,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: FontHeading.bodySmall.copyWith(
                            color: AppColors.CustomgrayDark,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  //  EMPTY STATE REUSABLE WIDGET (for consistency)
  // ============================================================
  Widget _buildEmptyState({
    IconData? icon,
    String? image,
    required String title,
    required String subtitle,
  }) {
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
            if (image != null)
              SizedBox(
                width: 122,
                height: 122,
                child: Image.asset(image, fit: BoxFit.contain),
              )
            else if (icon != null)
              Icon(icon, size: 48, color: AppColors.customGray),
            const SizedBox(height: 12),
            Text(
              title,
              style: FontHeading.body.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: FontHeading.bodySmall.copyWith(
                color: AppColors.customGray,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
