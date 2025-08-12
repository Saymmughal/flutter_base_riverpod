import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_data.dart';
import 'package:flutter_base_riverpod/utils/env_configuration/load_env_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/helper/routes_helper.dart';
import 'package:flutter_base_riverpod/helper/scroll_behaviour.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';

import 'helper/connection_manager.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables
  await LoadEnvFile.load();
  // For Firebase Initialization
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseMessaging.instance.getToken().then((value) {
  //   debugPrint("Token =======================>>>>>>>>>>> : $value");
  // });
  // FirebaseMessaging.instance.requestPermission();
  // To initialize Push notifications
  // await NotificationService().initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ConnectionManager().initialize();

    // Watch theme changes
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Base Project',
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: _getThemeMode(themeMode),
      initialRoute: RouterHelper.initial,
      routes: RouterHelper.routes,
    );
  }

  ThemeMode _getThemeMode(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
