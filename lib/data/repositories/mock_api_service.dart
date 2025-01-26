import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MockApiService {
  // Simulate user registration
  Future<bool> register(String fullName, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    final prefs = await SharedPreferences.getInstance();

    // Get the list of registered emails
    final registeredEmails = prefs.getStringList("registeredEmails") ?? [];

    // Check if the email already exists
    if (registeredEmails.contains(email)) {
      throw Exception("Email already registered.");
    }

    // Add the new email to the list
    registeredEmails.add(email);
    await prefs.setStringList("registeredEmails", registeredEmails);

    // Store user-specific information
    await prefs.setString("fullName:$email", fullName);
    await prefs.setString("password:$email", password);

    // Save the logged-in user
    await prefs.setString("loggedInUser", email);

    return true;
  }

  // Simulate user login
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    final prefs = await SharedPreferences.getInstance();

    // Get the list of registered emails
    final registeredEmails = prefs.getStringList("registeredEmails") ?? [];

    // Check if the email exists
    if (!registeredEmails.contains(email)) {
      throw Exception("Email not registered.");
    }

    // Verify the password
    final storedPassword = prefs.getString("password:$email");
    if (storedPassword != password) {
      throw Exception("Invalid password.");
    }

    // Save the logged-in user
    await prefs.setString("loggedInUser", email);

    return true;
  }

  // Get the logged-in user's full name
  Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("loggedInUser");
    if (email != null) {
      return prefs.getString("fullName:$email");
    }
    return null; // No user logged in
  }

  // Log out the user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("loggedInUser");
  }

  // Simulate fetching wallet data
  Future<Map<String, dynamic>> fetchWalletData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return {
      "balance": 1000.0,
      "transactions": [
        {
          "id": "T001",
          "amount": 100.0,
          "recipient": "John Doe",
          "date": "2025-01-01"
        },
        {
          "id": "T002",
          "amount": 50.0,
          "recipient": "Jane Smith",
          "date": "2025-01-10"
        },
      ],
    };
  }

  // Simulate sending money
  Future<bool> sendMoney(String recipient, double amount) async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate processing delay
    if (amount <= 0) {
      throw Exception("Invalid amount.");
    }
    return true; // Simulate success
  }
}
