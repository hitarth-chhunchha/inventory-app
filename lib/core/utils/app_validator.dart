import '../../constants/app_strings.dart';

class AppValidator {
  static bool isEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static String mobileRegex = r'^\d{10}$';
  static String passwordRegex =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$';

  static bool isMobile(String mobile) {
    RegExp regex = RegExp(mobileRegex);
    return regex.hasMatch(mobile);
  }

  static bool isPassword(String value) {
    RegExp regExp = RegExp(passwordRegex);
    return regExp.hasMatch(value);
  }

  /// mobile validator
  static String? mobileNumber({required String value}) {
    if (AppValidator.isEmpty(value)) {
      return AppStrings.enterMobileNumber;
    } else if (!AppValidator.isMobile(value)) {
      return AppStrings.enterValidMobileNumber;
    }

    return null;
  }

  /// password validator
  static String? password({required String value}) {
    if (AppValidator.isEmpty(value)) {
      return AppStrings.enterPassword;
    } else if (!AppValidator.isPassword(value)) {
      return _getPasswordValidationMessage(value);
    }

    return null;
  }

  static String _getPasswordValidationMessage(String password) {
    List<String> messages = [];

    if (password.length < 8) {
      messages.add("- At least 8 characters");
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      messages.add("- At least 1 uppercase letter (A-Z)");
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
      messages.add("- At least 1 lowercase letter (a-z)");
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(password)) {
      messages.add("- At least 1 number (0-9)");
    }
    if (!RegExp(r'(?=.*[\W_])').hasMatch(password)) {
      messages.add("- At least 1 special character");
    }

    return messages.isEmpty ? "" : messages.join("\n");
  }
}
