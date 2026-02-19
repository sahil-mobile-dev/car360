import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewerState {
  final int currentIndex;
  final double zoomLevel;
  final Color? colorFilter;
  final bool isLoading;

  ViewerState({
    this.currentIndex = 1,
    this.zoomLevel = 1.0,
    this.colorFilter,
    this.isLoading = false,
  });

  ViewerState copyWith({
    int? currentIndex,
    double? zoomLevel,
    Color? colorFilter,
    bool? isLoading,
  }) {
    return ViewerState(
      currentIndex: currentIndex ?? this.currentIndex,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      colorFilter: colorFilter ?? this.colorFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ViewerViewModel extends StateNotifier<ViewerState> {
  ViewerViewModel() : super(ViewerState());

  void updateIndex(double dx, double screenWidth) {
    // Sensitivity: how much drag corresponds to one image swap
    const sensitivity = 5.0;
    int delta = (dx / sensitivity).round();

    int newIndex = state.currentIndex + delta;

    // Wrap around 1-50
    if (newIndex > 50) newIndex = 1;
    if (newIndex < 1) newIndex = 50;

    if (newIndex != state.currentIndex) {
      state = state.copyWith(currentIndex: newIndex);
    }
  }

  void setZoom(double zoom) {
    state = state.copyWith(zoomLevel: zoom.clamp(1.0, 3.0));
  }

  void toggleColor(Color? color) {
    if (state.colorFilter == color) {
      state = state.copyWith(colorFilter: null);
    } else {
      state = state.copyWith(colorFilter: color);
    }
  }
}

final viewerViewModelProvider =
    StateNotifierProvider<ViewerViewModel, ViewerState>((ref) {
      return ViewerViewModel();
    });
