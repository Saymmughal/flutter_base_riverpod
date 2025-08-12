import 'package:flutter_base_riverpod/helper/connection_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/int_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/prrimary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/string_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/widget_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/theme_toggle_widget.dart';
import 'package:flutter_base_riverpod/utils/app_styles/style.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_colors.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';

import 'package:flutter_base_riverpod/helper/router_navigator.dart';
import 'package:flutter_base_riverpod/helper/routes_helper.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    callingAPIs();
    super.initState();
  }

  callingAPIs() {
    // Call APIs
  }

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(currentThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: 'Home'.toText(fontSize: 18, fontWeight: AppStyle.w600),
        centerTitle: true,
        backgroundColor: AppThemeColors.getSurface(currentThemeMode),
        actions: [const ThemeToggleWidget(), 8.width],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: AppThemeColors.getCardColor(currentThemeMode),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      size: 64,
                      color: AppThemeColors.getPrimary(currentThemeMode),
                    ),
                    16.height,
                    'Welcome to Home Screen'.toText(
                      fontSize: 20,
                      fontWeight: AppStyle.w600,
                      textAlign: TextAlign.center,
                    ),
                    8.height,
                    'This is your base Flutter project with Riverpod and dark theme support'
                        .toText(fontSize: 14, textAlign: TextAlign.center),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            buttonName: 'Test Connection',
                            onPressed: () {
                              ConnectionManager().showInternetError();
                            },
                          ),
                        ),
                        20.width,
                        Expanded(
                          child: PrimaryButton(
                            buttonName: 'Theme Demo',
                            onPressed: () {
                              goToNamed(RouterHelper.themeDemoScreen);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).center,
      ),
    );
  }
}
