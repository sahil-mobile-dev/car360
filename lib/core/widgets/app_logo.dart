import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 100,
    this.showText = true,
    this.fontSize,
  });

  final double size;
  final bool showText;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade800, Colors.blue.shade900],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow ring
              Container(
                margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2.w,
                  ),
                ),
              ),
              // Car Icon
              Icon(
                Icons.directions_car_filled,
                size: (size * 0.6).sp,
                color: Colors.white,
              ),
              // "360" badge
              Positioned(
                bottom: (size * 0.15).h,
                right: (size * 0.15).w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '360',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (size * 0.18).sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showText) ...[
          SizedBox(height: (size * 0.15).h),
          Text(
            'Car 360',
            style: TextStyle(
              fontSize: fontSize ?? (size * 0.32).sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.blue.shade900,
            ),
          ),
          Container(
            width: (size * 0.4).w,
            height: 3.h,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ],
    );
  }
}
