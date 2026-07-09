//lib/features/clinic/presentation/screens/clinic_detail_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/map/presentation/screens/map_test_screen.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClinicDetailScreen extends StatelessWidget {
  static const routeName = '/clinic-detail';
  final Clinic clinic;

  const ClinicDetailScreen({super.key, required this.clinic});

  // Clinic location (hardcoded for demo – replace with real data)
  final LatLng _clinicLocation = const LatLng(33.5138, 36.2765);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            //  SCROLLABLE CONTENT (fills remaining space)
            // ============================================================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ============================================================
                    //  UPPER SHEET (Image + Status Badge)
                    // ============================================================
                    Stack(
                      children: [
                        // ---- Image (200 height) ----
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.assetsImagesReception),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                        // ---- Status Badge (Top Right) ----
                        Positioned(
                          top: 30,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.main_background_white,
                              borderRadius: BorderRadius.circular(117),
                            ),
                            child: Icon(
                              Icons.bookmark,
                              color: clinic.isSaved
                                  ? AppColors.main_background_blue
                                  : AppColors.customGray,
                            ),
                          ),
                        ),
                        // ---- Back Button (Top Left - NO PADDING) ----
                        Positioned(
                          top: 30,
                          left: 10,
                          child: GestureDetector(
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
                        ),
                        Positioned(
                          bottom: 12,
                          left: 16,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 90,
                            child: Text(
                              clinic.name,
                              style: FontHeading.heading2,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 14,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
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
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade600,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ============================================================
                    //  About text
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'About',
                        style: FontHeading.heading3.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur. Ultricies magna vitae faucibus viverra facilisis dolor. Facilisi dui nunc arcu vel. Nascetur sed et auctor auctor a arcu cursus lectus. In quam justo suscipit purus vulputate habitant. Tempor.',
                        style: FontHeading.caption.copyWith(
                          color: AppColors.CustomgrayDark,
                        ),
                      ),
                    ),

                    // ============================================================
                    //  CLINIC NAME + LOCATION + MAP BUTTON
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: FontHeading.heading3.copyWith(
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.main_background_blue,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        'Damascus, Al-Mazzeh', // Replace with real location
                                        style: FontHeading.bodySmall.copyWith(
                                          color: AppColors.CustomgrayDark,
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
                          // ---- Map Button ----
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.main_background_blue,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MapTestScreen(
                                        clinic:
                                            clinic, // Pass clinic if available
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.map_outlined,
                                  color: AppColors.main_background_white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ============================================================
                    //  MINI MAP (Static, no interaction)
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _clinicLocation,
                              zoom: 15.0,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('clinic'),
                                position: _clinicLocation,
                                infoWindow: const InfoWindow(
                                  title: 'Clinic Location',
                                ),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue,
                                ),
                              ),
                            },
                            myLocationEnabled: false,
                            zoomControlsEnabled: false,
                            scrollGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            zoomGesturesEnabled: false,
                            mapType: MapType.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ============================================================
                    //  BOTTOM BUTTONS
                    // ============================================================
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 50),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Booking new appointment'),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Book an appointment',
                                style: FontHeading.button,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.main_background_blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
