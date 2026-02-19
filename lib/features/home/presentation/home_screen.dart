import 'package:car_360/core/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showLogo: true,
      title: 'Portal',
      appBarAction: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => context.push('/settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Explore\nYour Dream Car',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                height: 1.2,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Experience every detail in a fully interactive 360° environment.',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Hero(
                tag: 'car-preview',
                child: Image.asset(
                  'assets/images/car1.png',
                  width: 300.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              width: double.infinity,
              height: 60.h,
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: ElevatedButton(
                onPressed: () => context.push('/viewer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.threed_rotation, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'View in 360°',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
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
