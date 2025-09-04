import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/helper/router_navigator.dart';
import 'package:flutter_base_riverpod/helper/routes_helper.dart';
import 'package:flutter_base_riverpod/utils/app_styles/style.dart';
import 'package:flutter_base_riverpod/utils/dimension_manager.dart';
import 'package:flutter_base_riverpod/utils/font_scaling_manager.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/annotated_widget.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/string_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/widget_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/helper/debouncer.dart';
import 'package:flutter_base_riverpod/provider/auth_prividers/login_provider.dart';
import 'package:flutter_base_riverpod/utils/constant.dart';
import 'package:flutter_base_riverpod/view/widgets/custom_text_field.dart';
import 'package:flutter_base_riverpod/view/widgets/prrimary_button.dart';
import 'package:flutter_base_riverpod/helper/validation.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/int_extension.dart';
import 'package:flutter_base_riverpod/view/widgets/theme_toggle_widget.dart';
import 'package:flutter_base_riverpod/utils/app_styles/app_theme_colors.dart';
import 'package:flutter_base_riverpod/provider/theme_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final debouncer = Debouncer(milliseconds: 500);

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
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    final isLoading = ref.watch(isLoadingProvider);
    // final error = ref.watch(errorProvider);
    final currentThemeMode = ref.watch(currentThemeModeProvider);

    return annotatedRegionWidget(
      context: context,
      child: OrientationBuilder(
        builder: (context, orientation) {
          // Mark dimension manager for refresh on orientation change
          DimensionManager.instance.markForRefresh();
          // Clear font scaling cache on orientation change
          FontScalingManager.instance.clearCache();

          return Scaffold(
            key: scaffoldKey,
            extendBody: true,
            extendBodyBehindAppBar: true,
            // resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: 'Login'.toText(),
              centerTitle: true,
              backgroundColor: AppThemeColors.getSurface(currentThemeMode),
              actions: [const ThemeToggleWidget(), const SizedBox(width: 8)],
            ),
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // App Logo/Title
                      'Welcome Back'.toText(
                        fontSize: 28,
                        fontWeight: AppStyle.w700,
                        textAlign: TextAlign.center,
                      ),
                      20.height,
                      'Sign in to continue'.toText(
                        fontSize: 16,
                        color: AppThemeColors.getTextOnSurface(
                          currentThemeMode,
                        ).withValues(alpha: 179),
                        textAlign: TextAlign.center,
                      ),
                      40.height,

                      // Email Field
                      CustomTextField(
                        controller: loginState.loginEmailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) => Validation.emailValidation(value),
                        label: 'Email',
                      ),
                      20.height,

                      // Password Field
                      CustomTextField(
                        controller: loginState.loginPasswordController,
                        hintText: 'Password',
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            Validation.passwordValidation(value),
                        label: 'Password',
                      ),
                      30.height,

                      // Login Button
                      PrimaryButton(
                        buttonName: isLoading
                            ? 'Signing In...'
                            : AppConstant.loginText,
                        onPressed: isLoading
                            ? () {}
                            : () {
                                if (formKey.currentState!.validate()) {
                                  loginNotifier.login();
                                }
                              },
                      ),
                      20.height,

                      // Forgot Password
                      'Forgot Password?'
                          .toText(
                            fontSize: 16,
                            color: AppThemeColors.getPrimary(currentThemeMode),
                            fontWeight: AppStyle.w500,
                          )
                          .onPress(() {
                            goReplacementNamed(RouterHelper.mainScreen);
                            // Implement forgot password functionality
                            // For example, navigate to a Forgot Password screen
                          })
                          .center,
                    ],
                  ).paddingSymmetric(horizontal: 20.w),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
