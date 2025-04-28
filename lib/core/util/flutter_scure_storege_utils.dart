// Custom FlutterSecureStorageUtils
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageUtils {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Keys for secure storage
  static const String _userIdKey = 'userId';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';

  // Save a value to secure storage
  static Future<void> saveValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Retrieve a value from secure storage
  static Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  // Delete a value from secure storage
  static Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  // Save user details
  static Future<void> saveUserDetails(
      String userId, String userName, String userEmail) async {
    await saveValue(_userIdKey, userId);
    await saveValue(_userNameKey, userName);
    await saveValue(_userEmailKey, userEmail);
  }

  // Retrieve user details
  static Future<Map<String, String?>> getUserDetails() async {
    final userId = await getValue(_userIdKey);
    final userName = await getValue(_userNameKey);
    final userEmail = await getValue(_userEmailKey);
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  // Clear all user details
  static Future<void> clearUserDetails() async {
    await deleteValue(_userIdKey);
    await deleteValue(_userNameKey);
    await deleteValue(_userEmailKey);
  }
}
