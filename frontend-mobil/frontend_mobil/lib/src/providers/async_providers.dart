import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_mobil/src/api/content_service.dart';
import 'package:frontend_mobil/src/api/hierarchy_service.dart';
import 'package:frontend_mobil/src/models/content_model.dart';
import 'package:frontend_mobil/src/models/course_model.dart';

// Mevcut Provider'lar
final coursesProvider = FutureProvider.family<List<Course>, int>((ref, departmentId) async {
  final hierarchyService = ref.watch(hierarchyServiceProvider);
  return hierarchyService.getCourses(departmentId);
});

final courseContentsProvider = FutureProvider.family<List<Content>, String>((ref, courseId) async {
  final contentService = ref.watch(contentServiceProvider);
  return contentService.getContentsForCourse(courseId);
});

//
// "TANIMLANMAMIŞ" HATASININ ÇÖZÜMÜ (YENİ EKLENDİ):
//
final courseDetailProvider = FutureProvider.family<Course, String>((ref, courseId) async {
  // HierarchyService'teki yeni 'getCourseDetail' fonksiyonunu çağırır.
  final hierarchyService = ref.watch(hierarchyServiceProvider);
  return hierarchyService.getCourseDetail(courseId);
});