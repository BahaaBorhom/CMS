import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/appointment.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/map/presentation/screens/map_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppointmentDetailScreen extends StatelessWidget {
  static const routeName = '/appointment-detail';
  final Appointment appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

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
                        // ---- Status Badge (Top Left) ----
                        Positioned(
                          top: 30,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.main_background_white,
                              borderRadius: BorderRadius.circular(117),
                            ),
                            child: Text(
                              'Confirmed',
                              style: FontHeading.bodySmall.copyWith(
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ============================================================
                    //  DOCTOR INFO CARD (Overlapping the sheet bottom)
                    // ============================================================
                    Transform.translate(
                      offset: const Offset(0, -40),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // ---- Doctor Photo (SQUARE) ----
                            SizedBox(
                              width: 62,
                              height: 62,
                              child: ClipRect(
                                // ✅ Square, no border radius
                                child: Image.asset(
                                  Assets.assetsImagesDoctorFolanAlfolani,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            // ---- Doctor Name + Date/Time ----
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    appointment.doctorName,
                                    style: FontHeading.heading4.copyWith(
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        color: AppColors.black,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        appointment.date,
                                        style: FontHeading.bodySmall.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(
                                        Icons.access_time_outlined,
                                        color: AppColors.black,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        appointment.time,
                                        style: FontHeading.bodySmall.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                                  appointment.clinicName,
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MapTestScreen(
                                  //       clinic: null, // Pass clinic if available
                                  //     ),
                                  //   ),
                                  // );
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
                          height: 175,
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
                    //  DETAIL ROWS
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            label: 'Visit type:',
                            value: appointment.followUp ?? 'Follow-up visit',
                            valueColor: AppColors.main_background_blue,
                          ),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                            label: 'Complexity:',
                            value: 'Complex',
                            valueColor: AppColors.yellowDark,
                          ),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                            label: 'Status:',
                            value: 'Confirmed',
                            valueColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), // extra padding at the bottom of scroll
                  ],
                ),
              ),
            ),
            // ============================================================
            //  BOTTOM BUTTONS (Invisible bottom sheet – no background, no shadow)
            // ============================================================
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to calendar')),
                        );
                      },
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Add to calendar',
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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showCancelDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel appointment',
                        style: FontHeading.button.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Detail Row (Label: Value) ----
  Widget _buildDetailRow({
    required String label,
    required String value,
    Color valueColor = Colors.black,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: FontHeading.body.copyWith(color: AppColors.CustomgrayDark),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2.5),
          decoration: BoxDecoration(
            color: valueColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: FontHeading.bodySmall.copyWith(color: valueColor),
          ),
        ),
      ],
    );
  }

  // ---- Cancel Dialog ----
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
