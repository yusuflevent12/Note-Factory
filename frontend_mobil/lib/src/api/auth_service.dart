import 'package:dio/dio.dart';
import 'package:frontend_mobil/src/api/dio_client.dart';
import 'package:frontend_mobil/src/models/user_model.dart';

class AuthService {
  final Dio _dio = DioClient.instance;

  Future<User?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/token',
        data: FormData.fromMap({
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        DioClient.setAuthToken(token);
        // Backend'den tam kullanıcı bilgisi dönmediği için burada mock bir kullanıcı oluşturuyoruz.
        // Gerçek bir uygulamada, token'ı decode edebilir veya ayrı bir /me endpoint'i olabilirdi.
        return User(id: 1, email: email, fullName: 'Kullanıcı');
      }
      return null;
    } on DioException catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<User?> register(String email, String password, String fullName) async { // Added fullName
    try {
      final response = await _dio.post(
        '/api/v1/auth/register',
        data: {
          'email': email,
          'password': password,
          'full_name': fullName, // Pass fullName
        },
      );

      if (response.statusCode == 200) {
        // Kayıt sonrası otomatik giriş için token al
        return await login(email, password);
      }
      return null;
    } on DioException catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    DioClient.clearAuthToken();
  }
}
