class AuthFormValidatorHelper {
  static String validateEmail(String email) {
    if (email.isEmpty || !email.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String validatePassword(String password) {
    if (password.isEmpty || password.length < 7) {
      return 'Password must be at least 7 characters long.';
    }
    return null;
  }

  static String validateUsername(String username) {
    if (username.isEmpty || username.length < 4) {
      return 'Please enter at least 4 characters.';
    }
    return null;
  }
}
