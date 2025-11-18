import 'dart:io';
import 'package:dio/dio.dart';
import '../models/content_model.dart';
import '../core/constants.dart';
import 'dio_client.dart';

class ContentService {
  final DioClient _dioClient = DioClient();

  Future<List<ContentModel>> getContentForCourse(int courseId) async {
    try {
      final response = await _dioClient.get('/content/$courseId');
      final data = response.data;
      if (data is List) {
        return data
            .map((json) => ContentModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw Exception('İçerikler yüklenirken hata oluştu: ${e.message}');
    }
  }

  Future<ContentModel> uploadContent({
    required String title,
    String? description,
    required ContentType contentType,
    required int courseId,
    required File file,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'title': title,
        'description': description ?? '',
        'content_type': contentType.value,
        'course_id': courseId,
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final response = await _dioClient.post('/content/', data: formData);
      return ContentModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Geçersiz dosya formatı. Sadece PDF ve JPEG/PNG kabul edilir.');
      }
      throw Exception('İçerik yüklenirken hata oluştu: ${e.message}');
    }
  }

  String getContentUrl(String filePath) {
    if (filePath.startsWith('http')) {
      return filePath;
    }
    return '${AppConstants.baseUrl}$filePath';
  }
}