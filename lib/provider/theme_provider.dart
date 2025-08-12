import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/data/db/shared-preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode { system, light, dark }

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final themeModeIndex = await LocalDb.getThemeMode;
      if (themeModeIndex != null &&
          themeModeIndex < AppThemeMode.values.length) {
        state = AppThemeMode.values[themeModeIndex];
      }
    } catch (e) {
      // Fallback to system theme if there's an error
      state = AppThemeMode.system;
    }
  }

  Future<void> setThemeMode(AppThemeMode themeMode) async {
    if (state != themeMode) {
      state = themeMode;
      // Store theme mode without blocking the main thread
      _storeThemeMode(themeMode.index);
    }
  }

  Future<void> _storeThemeMode(int index) async {
    try {
      await LocalDb.storeThemeMode(index);
    } catch (e) {
      // Handle storage error silently
      debugPrint('Failed to store theme mode: $e');
    }
  }

  Future<void> toggleTheme() async {
    if (state == AppThemeMode.light) {
      await setThemeMode(AppThemeMode.dark);
    } else if (state == AppThemeMode.dark) {
      await setThemeMode(AppThemeMode.light);
    } else {
      // If system mode, check current system theme and switch to opposite
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.light) {
        await setThemeMode(AppThemeMode.dark);
      } else {
        await setThemeMode(AppThemeMode.light);
      }
    }
  }

  bool get isDarkMode {
    if (state == AppThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return state == AppThemeMode.dark;
  }

  AppThemeMode get currentThemeMode => state;
}

// Optimized providers to reduce rebuilds
final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

// Use select to only rebuild when the actual theme mode changes
final currentThemeModeProvider = Provider<AppThemeMode>((ref) {
  return ref.watch(themeProvider.select((themeMode) => themeMode));
});

// Optimized boolean provider that only rebuilds when dark mode status actually changes
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(
    themeProvider.select((themeMode) {
      if (themeMode == AppThemeMode.system) {
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark;
      }
      return themeMode == AppThemeMode.dark;
    }),
  );
});
