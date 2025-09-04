import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/utils/app_styles/colors.dart';
import 'package:flutter_base_riverpod/utils/dimension_manager.dart';
import 'package:flutter_base_riverpod/utils/font_scaling_manager.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/annotated_widget.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/int_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/string_extension.dart';
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
    // Initialize dimension manager and font scaling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DimensionManager.instance.initialize(context);
      FontScalingManager.instance.preCalculateCommonSizes();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update dimension manager when screen size changes
    DimensionManager.instance.forceRefresh(context);
  }

  @override
  Widget build(BuildContext context) {
    // Use optimized provider to reduce rebuilds
    final currentThemeMode = ref.watch(currentThemeModeProvider);

    final currentIndex = ref.watch(currentIndexProvider);
    final bottomNavigationIndex = ref.watch(bottomNavigationIndexProvider);
    final bottomNavigationIndexNameList = ref.watch(
      bottomNavigationIndexNameProvider,
    );

    return annotatedRegionWidget(
      context: context,
      child: OrientationBuilder(
        builder: (context, orientation) {
          // Mark dimension manager for refresh on orientation change
          DimensionManager.instance.markForRefresh();
          // Clear font scaling cache on orientation change
          FontScalingManager.instance.clearCache();

          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: bottomNavigationIndexNameList[currentIndex].toText(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              centerTitle: true,
              backgroundColor: AppColors.transparentColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: currentIndex == 1
                    ? AppColors.whitePrimary
                    : AppColors.blackDark,
                weight: 14.w,
              ),
              systemOverlayStyle: AppColors.whiteStatusBar,
            ),
            backgroundColor: AppThemeColors.getSurface(currentThemeMode),
            body: bottomNavigationIndex[currentIndex],
            bottomNavigationBar: BottomNavigation(
              currentIndex: 0,
              themeMode: currentThemeMode,
            ),
          );
        },
      ),
    );
  }
}
