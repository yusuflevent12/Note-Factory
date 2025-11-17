import 'package:dio/dio.dart';
import 'package:frontend_mobil/src/api/dio_client.dart';
import 'package:frontend_mobil/src/models/course_model.dart';

class HierarchyService {
  final Dio _dio = DioClient.instance;

  Future<List<Course>> getCourses() async {
    try {
      // readme.md'deki hiper-odaklanma felsefesi gereği şimdilik department_id sabit kodlanmıştır.
      const departmentId = 1;
      final response = await _dio.get('/api/v1/hierarchy/courses/$departmentId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Course.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Get courses error: $e');
      return [];
    }
  }
}
