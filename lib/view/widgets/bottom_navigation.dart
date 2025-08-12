import 'package:flutter_base_riverpod/provider/bottom_navigation_provider.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';
import 'package:flutter_base_riverpod/utils/app_styles/colors.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_colors.dart';
import 'package:flutter_base_riverpod/utils/constant.dart';
import 'package:flutter_base_riverpod/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/utils/app_styles/style.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/int_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/svg_image.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/widget_extension.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.themeMode,
  });

  final int currentIndex;
  final AppThemeMode themeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to theme changes to trigger rebuilds
    ref.watch(currentThemeModeProvider);

    final bottomNavigationNotifier = ref.read(
      bottomNavigationNotifierProvider.notifier,
    );
    final currentIndexState = ref.watch(currentIndexProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppThemeColors.getSurface(themeMode),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.greyLight,
            blurRadius: 20,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        elevation: 0.0,
        color: AppThemeColors.getSurface(themeMode),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 10.h,
          selectedFontSize: 10.h,
          selectedLabelStyle: AppStyle.labelMedium,
          unselectedLabelStyle: AppStyle.labelMedium,
          selectedItemColor: AppThemeColors.getPrimary(themeMode),
          unselectedItemColor: AppThemeColors.getTextOnSurface(themeMode),
          backgroundColor: AppThemeColors.getSurface(themeMode),
          elevation: 8,
          currentIndex: currentIndexState,
          onTap: (index) {
            // set the current index of the bottom navigation bar
            // the function is declared inside BottomNavigationProvider
            bottomNavigationNotifier.setCurrentIndex(index);
            if (currentIndex != index) {
              switch (index) {
                case 0:
                  bottomNavigationNotifier.setCurrentIndex(0);
                  break;
                case 1:
                  bottomNavigationNotifier.setCurrentIndex(1);
                  break;
                default:
                  break;
              }
            }
          },
          items: <BottomNavigationBarItem>[
            // Home
            BottomNavigationBarItem(
              icon: svgAssetImage(
                currentIndexState == 0
                    ? AppIcons.iconHomeFilled
                    : AppIcons.iconHome,
                height: 22.h,
                width: 22.h,
                color: currentIndexState == 0
                    ? AppThemeColors.getPrimary(themeMode)
                    : AppThemeColors.getTextOnSurface(
                        themeMode,
                      ).withValues(alpha: 153),
              ).paddingOnly(bottom: 5.h),
              label: AppConstant.homeText,
            ),
            // Menu
            BottomNavigationBarItem(
              icon: svgAssetImage(
                currentIndexState == 1
                    ? AppIcons.iconMenuFilled
                    : AppIcons.iconMenu,
                height: 18.h,
                width: 18.h,
                color: currentIndexState == 1
                    ? AppThemeColors.getPrimary(themeMode)
                    : AppThemeColors.getTextOnSurface(
                        themeMode,
                      ).withValues(alpha: 153),
              ).paddingOnly(bottom: 5.h),
              label: AppConstant.menuText,
            ),
          ],
        ),
      ),
    );
  }
}
