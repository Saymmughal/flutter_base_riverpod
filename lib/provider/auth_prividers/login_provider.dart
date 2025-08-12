import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/helper/connection_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/data/repository/api_repo.dart';
import 'package:flutter_base_riverpod/helper/router_navigator.dart';
import 'package:flutter_base_riverpod/utils/env_configuration/env_config.dart';
import 'package:flutter_base_riverpod/view/widgets/loading_dialog.dart';

import '../../data/db/shared-preferences.dart';
import '../../data/model/auth_model/login_model.dart';
import '../../helper/routes_helper.dart';
import '../../view/widgets/custom_snackbar.dart';

// State class for Login
class LoginState {
  final bool isLoading;
  final LoginModel? loginModel;
  final String? error;
  final TextEditingController loginEmailController;
  final TextEditingController loginPasswordController;

  const LoginState({
    this.isLoading = false,
    this.loginModel,
    this.error,
    required this.loginEmailController,
    required this.loginPasswordController,
  });

  LoginState copyWith({
    bool? isLoading,
    LoginModel? loginModel,
    String? error,
    TextEditingController? loginEmailController,
    TextEditingController? loginPasswordController,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      loginModel: loginModel ?? this.loginModel,
      error: error ?? this.error,
      loginEmailController: loginEmailController ?? this.loginEmailController,
      loginPasswordController:
          loginPasswordController ?? this.loginPasswordController,
    );
  }
}

// Login StateNotifier
class LoginNotifier extends StateNotifier<LoginState> {
  final ApiRepo _apiRepo;

  LoginNotifier(this._apiRepo)
    : super(
        LoginState(
          loginEmailController: TextEditingController(),
          loginPasswordController: TextEditingController(),
        ),
      );

  // Clear TextFields
  void clearSignInFields() {
    state.loginEmailController.clear();
    state.loginPasswordController.clear();
    state = state.copyWith();
  }

  // Clear Login Screen
  void clearLoginScreen() {
    clearSignInFields();
  }

  // Set Loading
  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
    if (value == true) {
      loaderDialog();
    } else {
      goBack();
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /*=================================================================================
  APIs calling
 ==================================================================================*/

  // LOGIN ===================================================

  // Login
  Future<void> login() async {
    state = state.copyWith(
      loginModel: LoginModel(),
      isLoading: true,
      error: null,
    );
    setLoading(true);
    Future.delayed(Duration(seconds: 3), () async {
      bool isConnected = ConnectionManager().showInternetError();
      if (!isConnected) {
        setLoading(false);
        return;
      }

      debugPrint("isLoading: ${state.isLoading}");
      debugPrint("Login ==========================>>>");
      try {
        Response response = await _apiRepo.postRequest(
          url: EnvConfig.fullLoginUrl,
          data: {
            "email": state.loginEmailController.text,
            "password": state.loginPasswordController.text,
          },
        );

        final responseBody = response.data;
        debugPrint("Login body ===============>>> $responseBody");

        final loginModel = LoginModel.fromJson(responseBody);

        if (response.statusCode == 200 || response.statusCode == 201) {
          setLoading(false);
          await Future.wait([
            LocalDb.storeUserData(loginModel),
            LocalDb.storeBearerToken(loginModel.token!),
            LocalDb.storeUserId(loginModel.data!.id!),
            LocalDb.storeLogin(true),
          ]);
          clearSignInFields();
          goToNamed(RouterHelper.mainScreen);
        } else {
          setLoading(false);
          String errorMessage =
              loginModel.error ??
              "${response.statusCode} ${response.statusMessage}";
          state = state.copyWith(error: errorMessage);
          showToast(message: errorMessage);
        }
      } catch (e) {
        setLoading(false);
        state = state.copyWith(error: e.toString());
        debugPrint("isLoading: ${state.isLoading}");
      }
    });
  }

  @override
  void dispose() {
    state.loginEmailController.dispose();
    state.loginPasswordController.dispose();
    super.dispose();
  }
}

// Providers
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>((
  ref,
) {
  return LoginNotifier(ApiRepo());
});

final loginStateProvider = Provider<LoginState>((ref) {
  return ref.watch(loginNotifierProvider);
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(loginStateProvider).isLoading;
});

final loginModelProvider = Provider<LoginModel?>((ref) {
  return ref.watch(loginStateProvider).loginModel;
});

final errorProvider = Provider<String?>((ref) {
  return ref.watch(loginStateProvider).error;
});

final loginEmailControllerProvider = Provider<TextEditingController>((ref) {
  return ref.watch(loginStateProvider).loginEmailController;
});

final loginPasswordControllerProvider = Provider<TextEditingController>((ref) {
  return ref.watch(loginStateProvider).loginPasswordController;
});
