// ignore_for_file: file_names

class InputValidators {
  static String? validateEmail(String email) {
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email address.";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.length < 8) {
      return "Password must be at least 8 characters.";
    }
    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!RegExp(r"[0-9]").hasMatch(password)) {
      return "Password must contain at least one number.";
    }
    return null;
  }

  static String? validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r"^\+?[0-9]{10,15}$");
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return "Enter a valid phone number.";
    }
    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) {
      return "Name cannot be empty.";
    }
    if (name.length < 2) {
      return "Name must be at least 2 characters.";
    }
    return null;
  }
}
