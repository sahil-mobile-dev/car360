import 'dart:math';
import 'package:car_360/features/viewer/presentation/viewer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:imageview360/imageview360.dart';

class ViewerScreen extends ConsumerStatefulWidget {
  const ViewerScreen({super.key});

  @override
  ConsumerState<ViewerScreen> createState() => _ViewerScreenState();
}

class _ViewerScreenState extends ConsumerState<ViewerScreen>
    with SingleTickerProviderStateMixin {
  final List<ImageProvider> _imageList = [];
  final bool _isDebugMode = false; // Debug mode disabled

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isPrecached = ref.read(viewerViewModelProvider).isPrecached;
    if (!isPrecached) {
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
      ref.read(viewerViewModelProvider.notifier).setPrecached(true);
    }
  }

  @override
  void initState() {
    super.initState();
    // Force Landscape for Viewer
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Reset to Portrait on exit
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
            child: !state.isPrecached
                ? const CircularProgressIndicator(color: Colors.white)
                : AspectRatio(
                    aspectRatio: 16 / 9, // Lock to image aspect ratio (16:9)
                    child: InteractiveViewer(
                      // minScale: 1.0,
                      // maxScale: 1.0, // Zoom Disabled
                      // panEnabled: false,
                      // scaleEnabled: false, // Zoom Disabled
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              ImageView360(
                                key: const ValueKey('viewer360'),
                                imageList: _imageList,
                                autoRotate: false,
                                rotationCount: 1,
                                swipeSensitivity: 2,
                                allowSwipeToRotate: true,
                                onImageIndexChanged: (index) {
                                  if (index != null) {
                                    viewModel.updateIndex(index);
                                  }
                                },
                              ),
                              // Hotspots Overlay
                              ..._buildHotspots(
                                state.currentIndex,
                                constraints,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ),
          // Debug Overlay
          if (_isDebugMode)
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black54,
                child: Text(
                  'Frame: ${state.currentIndex}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
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
            bottom: min(30.h, 15.w),
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swipe, color: Colors.white70, size: 20.sp),
                  SizedBox(height: 4.h),
                  Text(
                    'Rotate horizontally',
                    style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ),

          // Color Toggles (Commented Out as requested)
          /*
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
          */
        ],
      ),
    );
  }

  List<Widget> _buildHotspots(
    int currentImageIndex,
    BoxConstraints constraints,
  ) {
    final List<_HotspotData> hotspots = [
      _HotspotData(
        framePositions: {
          // Engine (Visible on Front F0-F2, F48-F49)
          // 48: const Offset(0.50, 0.35),
          // 49: const Offset(0.50, 0.35),
          0: const Offset(0.50, 0.35),
          1: const Offset(0.50, 0.35),
          2: const Offset(0.50, 0.35),
        },
        label: 'Side-Door',
        description: 'Side Door Details',
      ),
    ];

    return hotspots
        .where((h) => h.framePositions.containsKey(currentImageIndex))
        .map((h) {
      final position = h.framePositions[currentImageIndex]!;
      return Positioned(
        left: constraints.maxWidth * position.dx,
        top: constraints.maxHeight * position.dy,
        child: _HotspotMarker(onTap: () => _showHotspotInfo(h)),
      );
    }).toList();
  }

  void _showHotspotInfo(_HotspotData hotspot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(hotspot.label),
        content: Text(hotspot.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _HotspotData {
  final Map<int, Offset> framePositions;
  final String label;
  final String description;

  _HotspotData({
    required this.framePositions,
    required this.label,
    required this.description,
  });
}

class _HotspotMarker extends StatelessWidget {
  final VoidCallback onTap;

  const _HotspotMarker({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.2), // Static outer ring
        ),
        child: Center(
          child: Container(
            width: 14.w,
            height: 14.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
