import 'package:car_360/core/widgets/app_logo.dart';
import 'package:car_360/core/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Settings',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const AppLogo(size: 80, showText: false),
                  SizedBox(height: 16.h),
                  Text(
                    'Car 360',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Version ${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildSection(
              context,
              'About the App',
              'Car 360 is a cutting-edge interactive platform designed to showcase vehicles in a full 360° environment. Experience every angle, detail, and color with precision.',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              context,
              'Key Features',
              '• Fully Interactive 360° View: Rotate the car in any direction to see every detail.\n'
                  '• Real-time Color Customization: Toggle between different premium paint finishes.\n'
                  '• High-Definition Previews: Explore the vehicle with high-quality assets and smooth animations.\n'
                  '• Responsive Design: Optimized for seamless operation on all device orientations.',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              context,
              'Contact & Support',
              'For inquiries, support, or feedback, please contact us at support@car360.com or visit our website at www.car360.com.',
            ),
            SizedBox(height: 40.h),
            const Divider(),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  '© 2026 Car 360. All rights reserved.',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          content,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }
}
