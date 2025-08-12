import 'package:flutter_base_riverpod/utils/constant.dart';

class Validation {
  // Name text field validation
  static nameValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourName;
    }
  }

  // Name text field validation
  static fisrtNameValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourFirstName;
    }
  }

  static lastNameValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourLastName;
    }
  }

  static dateOfBirthValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterDateOfBirth;
    }
  }

  static addressValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourAddress;
    }
  }

  // Email text field validation
  static emailValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourEmail;
    } else if (!RegExp(
      r"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}",
    ).hasMatch(value.trim())) {
      return AppConstant.pleaseEnterValidEmail;
    } else {
      return null;
    }
  }

  // Phone text field validation
  static phoneValidation(String? value) {
    String pattern = r'^\d{10}$';
    RegExp regExp = RegExp(pattern);

    if (value!.trim().isEmpty) {
      return AppConstant.enterYourPhoneNumber;
    } else if (!regExp.hasMatch(value.trim())) {
      return AppConstant.enterValidPhoneNumber;
    }
  }

  // Password text field validation
  static passwordValidation(String? value) {
    String pattern = r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%&+]).{8,}$";
    RegExp regExp = RegExp(pattern);
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourPassword;
    } else if (!regExp.hasMatch(value.trim())) {
      return AppConstant.passwordValidaion;
    } else if (value.length < 8) {
      return AppConstant.passwordAtleast8Characters;
    }
  }

  static reEnterPasswordValidation(String? value, String confirmationValue) {
    if (value!.trim().isEmpty) {
      return AppConstant.enterYourPassword;
    } else if (value.toLowerCase().trim() !=
        confirmationValue.toLowerCase().trim()) {
      return AppConstant.passwordIsNotMatched;
    }
  }

  // Verification Code text field validation
  static verificationCodeValidation(String? value) {
    if (value!.trim().length < 6) {
      return AppConstant.pleaseEnterValidCode;
    } else if (value.trim().length > 6) {
      return AppConstant.pleaseEnterValidCode;
    }
  }

  // Cancel Reason text field validation
  static reasonValidation(String? value) {
    if (value!.trim().isEmpty) {
      return AppConstant.pleeaseEnterReason;
    }
  }
}
