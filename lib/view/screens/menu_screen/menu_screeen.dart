import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/utils/app_styles/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/string_extension.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_colors.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/widget_extension.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to theme changes to trigger rebuilds
    final currentThemeMode = ref.watch(currentThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: 'Menu'.toText(fontSize: 18, fontWeight: AppStyle.w600),
        centerTitle: true,
        backgroundColor: AppThemeColors.getSurface(currentThemeMode),
      ),
      backgroundColor: AppThemeColors.getSurface(currentThemeMode),
      body: Container(child: 'Menu Screen'.toText()).center,
    );
  }
}
