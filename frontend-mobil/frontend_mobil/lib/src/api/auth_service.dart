import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'dio_client.dart';

class AuthService {
  final DioClient _dioClient = DioClient();

  Future<TokenResponse> login(String email, String password) async {
    try {
      final formData = FormData.fromMap({
        'username': email, // OAuth2PasswordRequestForm uses 'username' field
        'password': password,
      });

      final response = await _dioClient.dio.post(
        '/auth/token',
        data: formData,
      );

      final tokenResponse = TokenResponse.fromJson(response.data);
      await _dioClient.setAuthToken(tokenResponse.accessToken);
      return tokenResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('E-posta veya şifre hatalı');
      }
      throw Exception('Giriş yapılırken bir hata oluştu: ${e.message}');
    } catch (e) {
      throw Exception('Giriş yapılırken bir hata oluştu: $e');
    }
  }

  Future<UserModel> register(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Bu e-posta adresi zaten kullanılıyor');
      }
      throw Exception('Kayıt olurken bir hata oluştu: ${e.message}');
    } catch (e) {
      throw Exception('Kayıt olurken bir hata oluştu: $e');
    }
  }

  Future<void> logout() async {
    await _dioClient.clearAuthToken();
  }
}

