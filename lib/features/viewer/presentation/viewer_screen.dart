import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_360/features/viewer/presentation/viewer_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:imageview360/imageview360.dart';
import 'package:car_360/core/widgets/app_logo.dart';

class ViewerScreen extends ConsumerStatefulWidget {
  const ViewerScreen({super.key});

  @override
  ConsumerState<ViewerScreen> createState() => _ViewerScreenState();
}

class _ViewerScreenState extends ConsumerState<ViewerScreen> {
  final List<ImageProvider> _imageList = [];
  bool _imagePrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_imagePrecached) {
      _precacheImages();
    }
  }

  Future<void> _precacheImages() async {
    for (int i = 1; i <= 50; i++) {
      final imageProvider = AssetImage('assets/images/car$i.png');
      _imageList.add(imageProvider);
      await precacheImage(imageProvider, context);
    }
    if (mounted) {
      setState(() {
        _imagePrecached = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Lock to landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Hide status bars for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore orientations and UI mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(viewerViewModelProvider);
    final viewModel = ref.read(viewerViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 360 Viewer Area
          Center(
            child: !_imagePrecached
                ? const CircularProgressIndicator(color: Colors.white)
                : InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 3.0,
                    onInteractionUpdate: (details) {
                      // We could use this for zoom if we wanted to manage zoom via state
                      // but for now let InteractiveViewer handle standard pinch
                    },
                    child: ColorFiltered(
                      colorFilter: state.colorFilter != null
                          ? ColorFilter.mode(
                              state.colorFilter!,
                              BlendMode.modulate,
                            )
                          : const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.dst,
                            ),
                      child: Hero(
                        tag: 'car-preview',
                        child: ImageView360(
                          key: UniqueKey(),
                          imageList: _imageList,
                          autoRotate: false,
                          rotationCount: 1,
                          swipeSensitivity: 2,
                          allowSwipeToRotate: true,
                          onImageIndexChanged: (index) {
                            // Sync with our state if needed, but the package handles it internally
                          },
                        ),
                      ),
                    ),
                  ),
          ),

          // HUD / Controls
          Positioned(
            top: 15.h,
            left: 20.w,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: () => context.pop(),
            ),
          ),

          // Rotation Indicator
          Positioned(
            bottom: min(30.h, 15.w), // Adjust for narrow landscape
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swipe, color: Colors.white70, size: 20.sp),
                  SizedBox(height: 4.h),
                  Text(
                    'Drag horizontally to rotate',
                    style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ),

          // Color Toggles
          Positioned(
            right: 15.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ColorButton(
                      color: Colors.red.shade400,
                      isSelected: state.colorFilter == Colors.red.shade400,
                      onTap: () => viewModel.toggleColor(Colors.red.shade400),
                    ),
                    SizedBox(height: 12.h),
                    _ColorButton(
                      color: Colors.blue.shade400,
                      isSelected: state.colorFilter == Colors.blue.shade400,
                      onTap: () => viewModel.toggleColor(Colors.blue.shade400),
                    ),
                    SizedBox(height: 12.h),
                    _ColorButton(
                      color: Colors.green.shade400,
                      isSelected: state.colorFilter == Colors.green.shade400,
                      onTap: () => viewModel.toggleColor(Colors.green.shade400),
                    ),
                    SizedBox(height: 12.h),
                    _ColorButton(
                      color: Colors.white,
                      isSelected: state.colorFilter == null,
                      isDefault: true,
                      onTap: () => viewModel.toggleColor(null),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDefault;

  const _ColorButton({
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.isDefault = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 14.r,
          child: isDefault
              ? Icon(Icons.close, size: 14.sp, color: Colors.black)
              : null,
        ),
      ),
    );
  }
}
