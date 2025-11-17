import 'package:dio/dio.dart';
import '../models/course_model.dart';
import 'dio_client.dart';

class HierarchyService {
  final DioClient _dioClient = DioClient();

  Future<List<UniversityModel>> getUniversities() async {
    try {
      final response = await _dioClient.dio.get('/hierarchy/universities');
      return (response.data as List)
          .map((json) => UniversityModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Üniversiteler yüklenirken hata oluştu: ${e.message}');
    }
  }

  Future<List<FacultyModel>> getFaculties(int universityId) async {
    try {
      final response =
          await _dioClient.dio.get('/hierarchy/faculties/$universityId');
      return (response.data as List)
          .map((json) => FacultyModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Fakülteler yüklenirken hata oluştu: ${e.message}');
    }
  }

  Future<List<DepartmentModel>> getDepartments(int facultyId) async {
    try {
      final response =
          await _dioClient.dio.get('/hierarchy/departments/$facultyId');
      return (response.data as List)
          .map((json) =>
              DepartmentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Bölümler yüklenirken hata oluştu: ${e.message}');
    }
  }

  Future<List<CourseModel>> getCourses(int departmentId) async {
    try {
      final response =
          await _dioClient.dio.get('/hierarchy/courses/$departmentId');
      return (response.data as List)
          .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Dersler yüklenirken hata oluştu: ${e.message}');
    }
  }
}

