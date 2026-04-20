class AuthValidator {
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  static Map<String, bool> validatePassword(String password) {
    return {
      "length": password.length >= 8,
      "uppercase": RegExp(r'[A-Z]').hasMatch(password),
      "lowercase": RegExp(r'[a-z]').hasMatch(password),
      "number": RegExp(r'[0-9]').hasMatch(password),
      "special": RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
    };
  }
}
