import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({String baseUrl = 'http://10.0.2.2:8000/api/v1'})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: 10000,
          receiveTimeout: 10000,
          responseType: ResponseType.json,
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Token eklemek gerekiyorsa burada yapın
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        // 500 gibi server hatalarını burada yakala ve anlamlı hale getir
        if (e.response != null && e.response?.statusCode != null) {
          final code = e.response!.statusCode!;
          if (code >= 500) {
            return handler.reject(DioError(
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

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {data}) => dio.post(path, data: data);
}
