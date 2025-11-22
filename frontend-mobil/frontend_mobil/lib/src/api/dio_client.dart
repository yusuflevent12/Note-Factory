import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  String? _token;

  DioClient({String baseUrl = 'http://10.0.2.2:8000/api/v1'})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 10000),
          receiveTimeout: const Duration(milliseconds: 10000),
          responseType: ResponseType.json,
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null && _token!.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response != null && e.response?.statusCode != null) {
          final code = e.response!.statusCode!;
          if (code >= 500) {
            return handler.reject(DioException(
              requestOptions: e.requestOptions,
              error: 'Sunucu hatası (500+) — lütfen daha sonra tekrar deneyin.',
              type: e.type,
              response: e.response,
            ));
          }
        }
        return handler.next(e);
      },
    ));
  }

  void setAuthToken(String? token) {
    _token = token;
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }

  void clearAuthToken() {
    setAuthToken(null);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {dynamic data, Options? options}) => 
      dio.post(path, data: data, options: options);
}