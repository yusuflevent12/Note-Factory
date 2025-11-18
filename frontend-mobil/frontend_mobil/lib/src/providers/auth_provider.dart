import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/dio_client.dart';
import '../api/auth_service.dart';
import '../core/constants.dart';
import '../models/user_model.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final UserModel? user;

  AuthState({
    this.isAuthenticated = false,
    this.token,
    this.user,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    UserModel? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService = AuthService();
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState()) {
    _loadSavedToken();
  }

  Future<void> _loadSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(isAuthenticated: true, token: token);
      // dio client ile senkronize et
      ref.read(dioClientProvider).setAuthToken(token);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final tokenResponse = await _authService.login(email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.tokenKey, tokenResponse.accessToken);
      await prefs.setString(AppConstants.userEmailKey, email);

      state = state.copyWith(
        isAuthenticated: true,
        token: tokenResponse.accessToken,
      );

      // DioClient'a tokenı set et
      ref.read(dioClientProvider).setAuthToken(tokenResponse.accessToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.register(email, password);
      await login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userEmailKey);
    state = AuthState();
    ref.read(dioClientProvider).clearAuthToken();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});