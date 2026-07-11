class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateEmptyText(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    // E.164 format: + followed by 7 to 15 digits
    final phoneRegExp = RegExp(r'^\+[1-9]\d{6,14}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number (e.g. +4915112345678)';
    }
    return null;
  }
}
