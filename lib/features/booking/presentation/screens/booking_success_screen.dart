import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatelessWidget {
  static const routeName = '/booking-success';

  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Column(
        children: [
          // ---- Blue Header ----
          _buildBlueHeader(context),
          // ---- Success Content ----
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ---- Checkmark Icon ----
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.green,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ---- Title ----
                    Text(
                      'Request Submitted',
                      style: FontHeading.heading1.copyWith(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // ---- Description ----
                    Text(
                      'You will receive a notification once the clinic confirms your appointment time',
                      style: FontHeading.body.copyWith(
                        color: AppColors.CustomgrayDark,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // ---- Pending Review Badge ----
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Text(
                        'Pending Review',
                        style: FontHeading.body.copyWith(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ---- Double Bottom Buttons ----
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  // ============================================================
  //  BLUE HEADER
  // ============================================================
  Widget _buildBlueHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.main_background_blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Row(
        children: [
          // ---- Back Button (Pill-shaped white) ----
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Back to home',
                    style: FontHeading.bodySmall.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // ---- Title ----
          Text(
            'Booking successful',
            style: FontHeading.heading4.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  DOUBLE BOTTOM BUTTONS
  // ============================================================
  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---- Primary Button ----
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to My Appointments
                // Navigator.pushNamed(context, '/my-appointments');
              },
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 20,
              ),
              label: const Text(
                'View MyAppointments',
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
          // ---- Secondary Button ----
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to home
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main_background_blue.withValues(
                  alpha: 0.1,
                ),
                foregroundColor: AppColors.main_background_blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.transparent,
              ),
              child: Text(
                'Back to Home',
                style: FontHeading.button.copyWith(
                  color: AppColors.main_background_blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
