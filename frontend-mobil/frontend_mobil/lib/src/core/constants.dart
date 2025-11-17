class AppConstants {
  // API Base URL - Android emulator için localhost
  // Gerçek cihazda kullanmak için bilgisayarın IP adresini kullanın
  static const String baseUrl = 'http://192.168.1.79:8000';
  static const String apiBaseUrl = '$baseUrl/api/v1';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userEmailKey = 'user_email';

  // App Colors
  static const int primaryColor = 0xFF2196F3; // Material Blue
  static const int secondaryColor = 0xFF03A9F4;
  static const int backgroundColor = 0xFFF5F5F5;
  static const int cardColor = 0xFFFFFFFF;
  static const int textColor = 0xFF212121;
  static const int textSecondaryColor = 0xFF757575;
}

