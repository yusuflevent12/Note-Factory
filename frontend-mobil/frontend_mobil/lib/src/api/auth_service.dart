import 'package:dio/dio.dart';
import 'dio_client.dart';
import '../models/user_model.dart';

class AuthService {
  final DioClient _dioClient = DioClient();

  Future<TokenResponse> login(String email, String password) async {
    try {
      final response = await _dioClient.post('/auth/login', data: {
        'username': email, // OAuth2 uses username usually
        'password': password,
      }, options: Options(contentType: Headers.formUrlEncodedContentType));
      
      return TokenResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Giriş başarısız: ${e.message}');
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _dioClient.post('/auth/register', data: {
        'email': email,
        'password': password,
      });
    } on DioException catch (e) {
      throw Exception('Kayıt başarısız: ${e.message}');
    }
  }

  Future<void> logout() async {
    // Backend'de logout endpoint'i varsa çağırılabilir
    // await _dioClient.post('/auth/logout');
  }
}