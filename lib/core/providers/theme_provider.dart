import 'package:car_360/core/services/local_storage_service.dart';
import 'package:car_360/injection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String _themeKey = 'theme_mode';
  late final LocalStorageService _storage;

  @override
  ThemeMode build() {
    _storage = ref.watch(localStorageServiceProvider);
    final savedTheme = _storage.read(_themeKey);

    if (savedTheme == 'dark') return ThemeMode.dark;
    if (savedTheme == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  Future<void> toggleTheme(bool isDark) async {
    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    state = mode;
    await _storage.save(_themeKey, isDark ? 'dark' : 'light');
  }
}
