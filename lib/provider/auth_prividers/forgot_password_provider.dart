import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/data/model/auth_model/forgot_password_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/data/repository/api_repo.dart';
import 'package:flutter_base_riverpod/helper/router_navigator.dart';
import 'package:flutter_base_riverpod/utils/env_configuration/env_config.dart';
import 'package:flutter_base_riverpod/view/widgets/loading_dialog.dart';

import '../../view/widgets/custom_snackbar.dart';

// State class for Forgot Password
class ForgotPasswordState {
  final bool isLoading;
  final ForgotPasswordModel? forgotPasswordModel;
  final String? error;
  final TextEditingController forgotPasswordEmailController;

  const ForgotPasswordState({
    this.isLoading = false,
    this.forgotPasswordModel,
    this.error,
    required this.forgotPasswordEmailController,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    ForgotPasswordModel? forgotPasswordModel,
    String? error,
    TextEditingController? forgotPasswordEmailController,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      forgotPasswordModel: forgotPasswordModel ?? this.forgotPasswordModel,
      error: error ?? this.error,
      forgotPasswordEmailController:
          forgotPasswordEmailController ?? this.forgotPasswordEmailController,
    );
  }
}

// Forgot Password StateNotifier
class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final ApiRepo _apiRepo;

  ForgotPasswordNotifier(this._apiRepo)
    : super(
        ForgotPasswordState(
          forgotPasswordEmailController: TextEditingController(),
        ),
      );

  // Clear TextFields
  void clearSignInFields() {
    state.forgotPasswordEmailController.clear();
    state = state.copyWith();
  }

  // Clear Forgot Password Screen
  void clearForgotPasswordScreen() {
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

  // FORGOT PASSWORD ===================================================
  // Forgot Password
  Future<void> forgotPassword() async {
    state = state.copyWith(isLoading: true, error: null);

    final email = state.forgotPasswordEmailController.text.trim();

    if (email.isEmpty) {
      showToast(message: "Please enter your email address");
      return;
    }
    setLoading(true);
    
    debugPrint("isLoading: ${state.isLoading}");
    debugPrint("Forgot Password API called with email: $email");

    try {
      Response response = await _apiRepo.postRequest(
        url: EnvConfig
            .fullForgotPasswordUrl, // You must define this in EnvConfig
        data: {"email": email},
      );

      final responseBody = response.data;
      debugPrint("Login body ===============>>> $responseBody");

      final forgotPasswordModel = ForgotPasswordModel.fromJson(responseBody);

      debugPrint("Forgot Password Model: $forgotPasswordModel");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setLoading(false);
        showToast(message: "Password reset link sent to your email");
        // Optionally clear email field
        state.forgotPasswordEmailController.clear();
      } else {
        setLoading(false);
        String errorMessage =
            response.data["error"] ??
            "${response.statusCode} ${response.statusMessage}";
        state = state.copyWith(error: errorMessage);
        showToast(message: errorMessage);
      }
    } catch (e) {
      setLoading(false);
      state = state.copyWith(error: e.toString());
      debugPrint("Forgot Password Error: $e");
      showToast(message: "Something went wrong. Please try again.");
    }
  }

  @override
  void dispose() {
    state.forgotPasswordEmailController.dispose();
    super.dispose();
  }
}

// Providers
final forgotPasswordNotifierProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
      return ForgotPasswordNotifier(ApiRepo());
    });

final forgotPasswordStateProvider = Provider<ForgotPasswordState>((ref) {
  return ref.watch(forgotPasswordNotifierProvider);
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(forgotPasswordStateProvider).isLoading;
});

final forgotPasswordProvider = Provider<ForgotPasswordModel?>((ref) {
  return ref.watch(forgotPasswordStateProvider).forgotPasswordModel;
});

final errorProvider = Provider<String?>((ref) {
  return ref.watch(forgotPasswordStateProvider).error;
});

final forgotPasswordEmailControllerProvider = Provider<TextEditingController>((
  ref,
) {
  return ref.watch(forgotPasswordStateProvider).forgotPasswordEmailController;
});
