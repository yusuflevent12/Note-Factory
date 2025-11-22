import '../models/course_model.dart';
import 'dio_client.dart';

class HierarchyService {
  final DioClient _client = DioClient();

  Future<List<CourseModel>> getCourses(int departmentId) async {
    final resp = await _client.get('/departments/$departmentId/courses');
    final data = resp.data;
    if (data is List) {
      return data
          .map((j) => CourseModel.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  // Düzeltildi: parametre ve dönüş tipi CourseModel (int parametre)
  Future<CourseModel> getCourseDetail(int courseId) async {
    final resp = await _client.get('/courses/$courseId');
    return CourseModel.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<List<dynamic>> getUniversities() async {
    final resp = await _client.get('/hierarchy/universities');
    return resp.data as List;
  }
}