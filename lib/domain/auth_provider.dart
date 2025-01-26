import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/mock_api_service.dart';

class AuthState {
  final bool isLoggedIn;
  final String? email;
  final String? error;
  final bool isShowPassword;

  AuthState({
    required this.isLoggedIn,
    this.email,
    this.error,
    this.isShowPassword = false,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  final MockApiService apiService;

  AuthNotifier(this.apiService) : super(AuthState(isLoggedIn: false));

  Future<void> login(String email, String password) async {
    try {
      await apiService.login(email, password);
      state = AuthState(isLoggedIn: true, email: email);
    } catch (e) {
      state = AuthState(isLoggedIn: false, error: e.toString());
    }
  }

  Future<void> register(String fullname, String email, String password) async {
    try {
      await apiService.register(fullname, email, password);
      state = AuthState(isLoggedIn: true, email: email);
    } catch (e) {
      state = AuthState(isLoggedIn: false, error: e.toString());
    }
  }

  void changePasswordVisibility(value) {
    state = AuthState(isLoggedIn: false, isShowPassword: value);
  }

  void logout() {
    state = AuthState(isLoggedIn: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(MockApiService()),
);
