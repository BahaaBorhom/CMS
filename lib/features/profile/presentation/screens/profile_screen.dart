import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:cms/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---- Blue Header ----
            _buildBlueHeader(context),
            const SizedBox(height: 16),
            // ---- Profile Card ----
            _buildProfileCard(context),
            // ---- Application Section ----
            _buildSettingsSection(
              title: 'Application',
              items: const [
                {
                  'icon': Icons.notifications_outlined,
                  'label': 'Notifications',
                },
                {'icon': Icons.translate, 'label': 'App Language'},
                {'icon': Icons.lock_outlined, 'label': 'Password & Security'},
              ],
            ),
            // ---- Support Section ----
            _buildSettingsSection(
              title: 'Support',
              items: const [
                {'icon': Icons.list, 'label': 'About Us'},
                {'icon': Icons.help_outline, 'label': 'Help Center & FAQ'},
                {'icon': Icons.phone_outlined, 'label': 'Contact Us'},
              ],
            ),
            const SizedBox(height: 16),
            // ---- Sign Out Button ----
            _buildSignOutButton(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  BLUE HEADER (exactly as provided)
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
        padding: const EdgeInsets.fromLTRB(24, 38, 16, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                // child:
                Text(
                  'Profile',
                  style: FontHeading.heading1.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // ),
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

  // ============================================================
  //  PROFILE CARD (Avatar + Name + Phone + Edit Button)
  // ============================================================
  Widget _buildProfileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.customGray,
            backgroundImage: AssetImage(Assets.assetsImagesUserFolanAlfolani),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Folan Al-Folani',
                  style: FontHeading.heading4.copyWith(color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: AppColors.CustomgrayDark,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '0900 000 000',
                      style: FontHeading.bodySmall.copyWith(
                        color: AppColors.CustomgrayDark,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ---- Edit Button ----
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // Navigate to Edit Profile Screen
              Navigator.pushNamed(context, EditProfileScreen.routeName);
            },
            icon: Container(
              child: const FaIcon(
                FontAwesomeIcons.edit,
                color: AppColors.main_background_blue,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  SETTINGS SECTION
  // ============================================================
  Widget _buildSettingsSection({
    required String title,
    required List<Map<String, dynamic>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Section Title ----
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 12, 16, 4),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: FontHeading.heading4.copyWith(
              color: AppColors.CustomgrayDark,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- List Items ----
              ...items.map((item) {
                return _buildSettingsTile(
                  icon: item['icon'] as IconData,
                  label: item['label'] as String,
                  onTap: () {
                    // Handle tap
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.CustomgrayDark, size: 24),
          title: Text(
            label,
            style: FontHeading.body.copyWith(color: Colors.black, fontSize: 16),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.customGray,
            size: 20,
          ),
          onTap: onTap,
        ),
        Divider(
          height: 0,
          thickness: 1,
          color: Colors.grey.shade100,
          indent: 56,
        ),
      ],
    );
  }

  // ============================================================
  //  SIGN OUT BUTTON (same style as cancel button)
  // ============================================================
  Widget _buildSignOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _showSignOutDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.logout_outlined, color: Colors.red, size: 20),
              const SizedBox(width: 8),
              Text(
                'Sign out',
                style: FontHeading.button.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  //  SIGN OUT DIALOG
  // ============================================================
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform sign out logic
              // Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Sign out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
