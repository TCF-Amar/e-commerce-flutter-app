class FormValidation {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Please enter a valid name';
    }
    if (value.length > 255) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    if (!value.contains('.')) {
      return 'Please enter a valid email address';
    }
    if (value.length < 3) {
      return 'Please enter a valid email address';
    }
    if (value.length > 255) {
      return 'Please enter a valid email address';
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    // if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
    //   return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character';
    // }
    return null;
  }

  static String? validateConfirmPassword(String password, String value) {
    if (value.isEmpty) {
      return 'Please enter your confirm password';
    }
    if (value != password) {
      return 'Confirm password does not match';
    }
    return null;
  }
}
