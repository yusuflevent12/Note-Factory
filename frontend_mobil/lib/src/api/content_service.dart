import 'package:dio/dio.dart';
import 'package:frontend_mobil/src/api/dio_client.dart';
import 'package:frontend_mobil/src/models/content_model.dart';
import 'dart:io';

class ContentService {
  final Dio _dio = DioClient.instance;

  Future<List<Content>> getContentForCourse(int courseId) async {
    try {
      final response = await _dio.get('/api/v1/content/$courseId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Content.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Get content for course error: $e');
      return [];
    }
  }

  Future<Content?> createContent({
    required String title,
    String? description,
    required ContentType contentType,
    required int courseId,
    required File file,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'title': title,
        'description': description,
        'content_type': contentType.toString().split('.').last,
        'course_id': courseId,
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _dio.post('/api/v1/content/', data: formData);

      if (response.statusCode == 200) {
        return Content.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Create content error: $e');
      return null;
    }
  }
}
