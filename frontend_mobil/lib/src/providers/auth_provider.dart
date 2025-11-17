import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_mobil/src/api/auth_service.dart';
import 'package:frontend_mobil/src/api/dio_client.dart';
import 'package:frontend_mobil/src/models/user_model.dart';

// 1. Auth State
class AuthState {
  final User? user;
  final bool isLoading;

  AuthState({this.user, this.isLoading = false});

  AuthState copyWith({User? user, bool? isLoading}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// 2. Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final user = await _authService.login(email, password);
    state = state.copyWith(user: user, isLoading: false);
  }

  Future<void> register(String email, String password, String fullName) async { // Added fullName
    state = state.copyWith(isLoading: true);
    final user = await _authService.register(email, password, fullName); // Pass fullName
    state = state.copyWith(user: user, isLoading: false);
  }

  Future<void> logout() async {
    await _authService.logout();
    state = AuthState(); // Reset state
  }
}

// 3. Providers
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(DioClient.instance);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
