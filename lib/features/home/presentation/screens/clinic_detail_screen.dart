import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/home/presentation/screens/map_test_screen.dart';
import 'package:flutter/material.dart';

class ClinicDetailScreen extends StatelessWidget {
  static const routeName = '/clinic-detail';
  final Clinic clinic;

  const ClinicDetailScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          clinic.name,
          style: FontHeading.heading1.copyWith(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                Assets.assetsImagesClinicPlaceholder,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              clinic.name,
              style: FontHeading.heading1.copyWith(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.main_background_blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                clinic.specialty,
                style: FontHeading.bodySmall.copyWith(
                  color: AppColors.main_background_blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 20),
                const SizedBox(width: 4),
                Text(
                  clinic.rating.toString(),
                  style: FontHeading.heading2.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: clinic.isSaved
                        ? AppColors.main_background_blue.withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        clinic.isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: clinic.isSaved
                            ? AppColors.main_background_blue
                            : AppColors.customGray,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        clinic.isSaved ? 'Saved' : 'Not saved',
                        style: FontHeading.bodySmall.copyWith(
                          color: clinic.isSaved
                              ? AppColors.main_background_blue
                              : AppColors.customGray,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildInfoRow(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: clinic.location,
            ),
            const SizedBox(height: 12),

            _buildInfoRow(
              icon: Icons.access_time_outlined,
              label: 'Working Hours',
              value: clinic.hours,
            ),
            const SizedBox(height: 12),

            _buildInfoRow(
              icon: Icons.map_outlined,
              label: 'Coordinates',
              value: '${clinic.latitude}, ${clinic.longitude}',
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapTestScreen(clinic: clinic),
                    ),
                  );
                },
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text(
                  'Show on Map',
                  style: FontHeading.button,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main_background_blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _openGoogleMaps(context);
                },
                icon: const Icon(Icons.directions, color: AppColors.main_background_blue),
                label: Text(
                  'Get Directions',
                  style: FontHeading.button.copyWith(
                    color: AppColors.main_background_blue,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.main_background_blue),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.main_background_blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.main_background_blue,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: FontHeading.bodySmall.copyWith(
                  color: AppColors.customGray,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: FontHeading.body.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openGoogleMaps(BuildContext context) async {
    // You'll need to add url_launcher package for this
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Google Maps...'),
      ),
    );
  }
}