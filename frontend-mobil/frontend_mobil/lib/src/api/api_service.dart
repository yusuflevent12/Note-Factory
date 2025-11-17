import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// "Jules"un (AI) AppConstants sınıfını (class) import et
import 'package:frontend_mobil/src/core/constants.dart'; 

//
// 1. "dioProvider" (Hata 1'in ÇÖZÜMÜ)
// Bu, tüm uygulama için 'Dio' (Backend bağlantısı)
// örneğini (instance) oluşturan Riverpod Provider'ıdır.
//
final dioProvider = Provider<Dio>((ref) {
  
  // 1. Temel "Mutfak" (Backend) ayarlarını yap
  final options = BaseOptions(
    // 2. "Jules"un (AI) 'AppConstants' sınıfından DOĞRU adresi al (Hata 2'nin ÇÖZÜMÜ)
    // (Dikkat: 'apiBaseUrl' değil, 'baseUrl' kullanıyoruz, 
    // çünkü API yolu '/api/v1'i *sonradan* ekleyeceğiz)
    baseUrl: AppConstants.baseUrl, // ('http://10.0.2.2:8000')
    
    connectTimeout: Duration(seconds: 30), // (30 saniye zaman aşımı)
    receiveTimeout: Duration(seconds: 30),
  );

  final dio = Dio(options);

  // 3. (Gelecek Vizyonu - Login)
  // "Jules" (AI) 'auth_provider'ı bitirdiğinde, bu 'interceptor' (araya girici)
  // her isteğe (request) 'Authorization' (Giriş Fişi/Token)
  // başlığını (header) otomatik ekleyecek.
  
  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       // TODO: Token'ı 'shared_preferences'tan oku
  //       // final token = ...; 
  //       // if (token != null) {
  //       //   options.headers['Authorization'] = 'Bearer $token';
  //       // }
  //       return handler.next(options);
  //     },
  //   ),
  // );

  return dio;
});


//
// 4. (Bonus) "Jules"un (AI) 'hierarchy_service.dart' gibi dosyalarının
// daha temiz çalışması için 'ApiService' sınıfı
//
class ApiService {
  final Dio _dio;

  // 'dioProvider'ı kullanarak 'ApiService'yi oluştur
  ApiService(this._dio);

  // (Buraya 'Jules' (AI) 'hierarchy_service.dart' ve 
  // 'content_service.dart'taki fonksiyonları taşıyabilir)
}

// (ApiService'yi de bir provider yapalım, 'Jules'un (AI) işi kolaylaşsın)
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider);
  return ApiService(dio);
});