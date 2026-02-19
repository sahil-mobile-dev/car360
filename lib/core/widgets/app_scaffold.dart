import 'package:car_360/core/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    super.key,
    this.title,
    this.appBarAction,
    this.showLogo = false,
  });
  final Widget body;
  final String? title;
  final Widget? appBarAction;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null || showLogo
          ? AppBar(
              title: showLogo
                  ? Row(
                      children: [
                        const AppLogo(size: 30, showText: false),
                        SizedBox(width: 10.w),
                        Text(
                          title ?? 'Car 360',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              actions: appBarAction != null ? [appBarAction!] : null,
            )
          : null,
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(16.w), child: body),
      ),
    );
  }
}
