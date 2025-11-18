import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_mobil/src/api/dio_client.dart';
import 'package:frontend_mobil/src/models/course_model.dart';
// Diğer model importları (University, Department)
// ...

final hierarchyServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return HierarchyService(dio);
});

class HierarchyService {
  final Dio _dio;
  HierarchyService(this._dio);

  // Mevcut ders listesi fonksiyonu
  Future<List<Course>> getCourses(int departmentId) async {
    try {
      final response = await _dio.get('/api/v1/hierarchy/courses/$departmentId');
      List<dynamic> data = response.data;
      return data.map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      // Hata yönetimi
      rethrow;
    }
  }

  //
  // EKSİK OLAN FONKSİYON (YENİ EKLENDİ):
  //
  Future<Course> getCourseDetail(String courseId) async {
    try {
      // Backend'e (hierarchy.py) eklediğimiz yeni endpoint'i çağır
      final response = await _dio.get('/api/v1/hierarchy/course/$courseId');
      // Dönen JSON verisini Course modeline çevir
      return Course.fromJson(response.data);
    } catch (e) {
      print('Kurs detayı alınırken hata: $e');
      rethrow;
    }
  }

  // Diğer hiyerarşi fonksiyonları (getUniversities, getDepartments) buraya eklenebilir
  // ...
}