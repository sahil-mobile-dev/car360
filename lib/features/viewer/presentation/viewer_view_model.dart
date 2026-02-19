import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewerState {
  final int currentIndex;
  final double zoomLevel;
  final Color? colorFilter;
  final bool isLoading;
  final bool isPrecached;

  ViewerState({
    this.currentIndex = 0,
    this.zoomLevel = 1.0,
    this.colorFilter,
    this.isLoading = false,
    this.isPrecached = false,
  });

  ViewerState copyWith({
    int? currentIndex,
    double? zoomLevel,
    Color? colorFilter,
    bool? isLoading,
    bool? isPrecached,
  }) {
    return ViewerState(
      currentIndex: currentIndex ?? this.currentIndex,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      colorFilter: colorFilter ?? this.colorFilter,
      isLoading: isLoading ?? this.isLoading,
      isPrecached: isPrecached ?? this.isPrecached,
    );
  }
}

class ViewerViewModel extends StateNotifier<ViewerState> {
  ViewerViewModel() : super(ViewerState());

  void setPrecached(bool value) {
    state = state.copyWith(isPrecached: value);
  }

  void updateIndex(int index) {
    if (state.currentIndex != index) {
      state = state.copyWith(currentIndex: index);
    }
  }

  void setZoom(double zoom) {
    state = state.copyWith(zoomLevel: zoom.clamp(1.0, 5.0));
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
