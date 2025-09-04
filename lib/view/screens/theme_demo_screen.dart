import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/utils/app_styles/style.dart';
import 'package:flutter_base_riverpod/utils/dimension.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/int_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/widget_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';
import 'package:flutter_base_riverpod/view/widgets/theme_toggle_widget.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/string_extension.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_colors.dart';

class ThemeDemoScreen extends ConsumerWidget {
  const ThemeDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(currentThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: 'Theme Demo'.toText(),
        backgroundColor: AppThemeColors.getSurface(currentThemeMode),
        actions: [const ThemeToggleWidget(), 16.width],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Theme Info
            Card(
              color: AppThemeColors.getCardColor(currentThemeMode),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Current Theme'.toText(
                      fontSize: 20,
                      fontWeight: AppStyle.w600,
                    ),
                    8.height,
                    Row(
                      children: [
                        Icon(
                          _getThemeIcon(currentThemeMode),
                          color: AppThemeColors.getPrimary(currentThemeMode),
                        ),
                        16.width,
                        _getThemeName(currentThemeMode).toText(fontSize: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            16.height,

            // Typography Section
            'Typography'.toText(fontSize: 18, fontWeight: AppStyle.w600),
            16.height,
            Card(
              color: AppThemeColors.getCardColor(currentThemeMode),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Display Large'.toText(
                      fontSize: 32,
                      fontWeight: AppStyle.w700,
                    ),
                    'Display Medium'.toText(
                      fontSize: 28,
                      fontWeight: AppStyle.w700,
                    ),
                    'Headline Large'.toText(
                      fontSize: 22,
                      fontWeight: AppStyle.w700,
                    ),
                    'Title Large'.toText(
                      fontSize: 16,
                      fontWeight: AppStyle.w700,
                    ),
                    'Body Large'.toText(fontSize: 16),
                    'Body Medium'.toText(fontSize: 14),
                    'Label Large'.toText(
                      fontSize: 14,
                      fontWeight: AppStyle.w500,
                    ),
                  ],
                ),
              ),
            ),
            16.height,

            // Colors Section
            'Colors'.toText(fontSize: 18, fontWeight: AppStyle.w600),
            16.height,
            Card(
              color: AppThemeColors.getCardColor(currentThemeMode),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildColorRow(
                      'Primary',
                      AppThemeColors.getPrimary(currentThemeMode),
                    ),
                    _buildColorRow(
                      'Secondary',
                      AppThemeColors.getSecondary(currentThemeMode),
                    ),
                    _buildColorRow(
                      'Surface',
                      AppThemeColors.getSurface(currentThemeMode),
                    ),
                    _buildColorRow(
                      'Surface',
                      AppThemeColors.getSurface(currentThemeMode),
                    ),
                    _buildColorRow(
                      'Error',
                      AppThemeColors.getError(currentThemeMode),
                    ),
                  ],
                ),
              ),
            ),
            16.height,

            // Components Section
            'Components'.toText(fontSize: 18, fontWeight: AppStyle.w600),
            16.height,
            Card(
              color: AppThemeColors.getCardColor(currentThemeMode),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Text Field',
                        hintText: 'Enter text here',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.height,

            // Theme Toggle Section
            'Theme Controls'.toText(fontSize: 18, fontWeight: AppStyle.w600),
            16.height,
            Card(
              color: AppThemeColors.getCardColor(currentThemeMode),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Use the theme toggle in the app bar to switch between themes:'
                        .toText(fontSize: 14),
                    16.height,
                    Row(
                      children: [
                        const Icon(Icons.brightness_auto),
                        16.width,
                        'System - Follows device theme'.toText(fontSize: 14),
                      ],
                    ),
                    8.height,
                    Row(
                      children: [
                        const Icon(Icons.light_mode),
                        16.width,
                        'Light - Always light theme'.toText(fontSize: 14),
                      ],
                    ),
                    8.height,
                    Row(
                      children: [
                        const Icon(Icons.dark_mode),
                        16.width,
                        'Dark - Always dark theme'.toText(fontSize: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            32.height,
          ],
        ).paddingSymmetric(horizontal: isLandscapePossible ? 50.w : 20.w),
      ),
    );
  }

  Widget _buildColorRow(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey),
            ),
          ),
          12.width,
          label.toText(fontWeight: AppStyle.w500),
          const Spacer(),
          '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}'
              .toText(fontSize: 12),
        ],
      ),
    );
  }

  IconData _getThemeIcon(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeName(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.light:
        return 'Light Theme';
      case AppThemeMode.dark:
        return 'Dark Theme';
      case AppThemeMode.system:
        return 'System Theme';
    }
  }
}
