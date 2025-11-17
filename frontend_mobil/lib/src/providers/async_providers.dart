import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_mobil/src/api/content_service.dart';
import 'package:frontend_mobil/src/api/hierarchy_service.dart';
import 'package/frontend_mobil/src/models/content_model.dart';
import 'package:frontend_mobil/src/models/course_model.dart';

// Service Providers
final hierarchyServiceProvider = Provider<HierarchyService>((ref) {
  return HierarchyService();
});

final contentServiceProvider = Provider<ContentService>((ref) {
  return ContentService();
});

// Data Providers
final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final hierarchyService = ref.watch(hierarchyServiceProvider);
  return hierarchyService.getCourses();
});

final contentForCourseProvider = FutureProvider.family<List<Content>, int>((ref, courseId) async {
  final contentService = ref.watch(contentServiceProvider);
  return contentService.getContentForCourse(courseId);
});
