//lib/features/clinic/presentation/screens/clinic_detail_screen.dart
import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
// import 'package:cms/features/map/presentation/screens/map_test_screen.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClinicDetailScreen extends StatelessWidget {
  static const routeName = '/clinic-detail';
  final Clinic clinic;

  const ClinicDetailScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============================================================
      //  BOTTOM BUTTONS
      // ============================================================
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.customGray,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking new appointment')),
                    );
                  },
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: const Text(
                    'Book an appointment',
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
            ],
          ),
        ),
      ),
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
                          decoration: BoxDecoration(
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
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: 200,
                        //     color: Colors.black26, // Adjust opacity as needed
                        //   ),
                        // ),
                        // ---- Status Badge (Top Right) ----
                        Positioned(
                          top: 30,
                          right: 10,
                          child: Container(
                            width: 37,
                            height: 37,
                            padding: const EdgeInsets.all(6.5),
                            decoration: BoxDecoration(
                              color: AppColors.main_background_white,
                              borderRadius: BorderRadius.circular(8),
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
                        Container(
                          height: 200,
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.6, 1],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
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
                      padding: const EdgeInsets.fromLTRB(24, 16, 0, 4),
                      child: Text(
                        'About',
                        style: FontHeading.heading3.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur. Ultricies magna vitae faucibus viverra facilisis dolor. Facilisi dui nunc arcu vel. Nascetur sed et auctor auctor a arcu cursus lectus. In quam justo suscipit purus vulputate habitant. Tempor.',
                        style: FontHeading.caption.copyWith(
                          color: AppColors.CustomgrayDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // ============================================================
                    //  LOCATION + MAP BUTTON
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                                        clinic.location,
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
                          height: 100,
                          width: double.infinity,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(clinic.latitude, clinic.longitude),
                              zoom: 15.0,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('clinic'),
                                position: LatLng(
                                  clinic.latitude,
                                  clinic.longitude,
                                ),
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
                    const SizedBox(height: 32),
                    // ============================================================
                    //  CONTACT INFO
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 0, 4),
                      child: Text(
                        'Contact info',
                        style: FontHeading.heading3.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.customGray.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: AppColors.main_background_blue,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "0900 000 000",
                              // clinic.contactnumber,
                              style: FontHeading.body.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // ============================================================
                    //  OPENING HOURS
                    // ============================================================
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.main_background_white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: AppColors.main_background_blue,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              clinic.hours,
                              style: FontHeading.body.copyWith(
                                color: AppColors.CustomgrayDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ============================================================
                    //  DOCTORS LIST
                    // ============================================================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 0, 4),
                      child: Text(
                        'Doctors',
                        style: FontHeading.heading3.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300, // Give it a fixed height or use Expanded
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return _DoctorCard();
                        },
                      ),
                    ),
                    const SizedBox(height: 150), // Add some space at the bottom
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _DoctorCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.customGray.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // ---- Doctor Photo (with fallback) ----
            SizedBox(
              width: 62,
              height: 62,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  Assets.assetsImagesDoctorFolanAlfolani,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image is missing
                    return Container(
                      color: AppColors.customGray,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            // ---- Doctor Info (no Expanded needed now) ----
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dr. Folan Al-Folani (Heart)',
                    style: FontHeading.heading4.copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '15 years of experience',
                        style: FontHeading.bodySmall.copyWith(
                          color: AppColors.CustomgrayDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.main_background_white,
                          borderRadius: BorderRadius.all(Radius.circular(117)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '4.5', // ✅ Hardcoded dummy rating (no clinic needed)
                              style: FontHeading.caption.copyWith(
                                color: AppColors.black,
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
