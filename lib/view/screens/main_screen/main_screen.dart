import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_riverpod/utils/app_styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/provider/bottom_navigation_provider.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';
import 'package:flutter_base_riverpod/view/widgets/bottom_navigation.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_colors.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use optimized provider to reduce rebuilds
    final currentThemeMode = ref.watch(currentThemeModeProvider);

    final currentIndex = ref.watch(currentIndexProvider);
    final bottomNavigationIndex = ref.watch(bottomNavigationIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppColors.systemUiOverlayStyle(context),
      child: Scaffold(
        backgroundColor: AppThemeColors.getSurface(currentThemeMode),
        body: bottomNavigationIndex[currentIndex],
        bottomNavigationBar: BottomNavigation(
          currentIndex: 0,
          themeMode: currentThemeMode,
        ),
      ),
    );
  }
}
