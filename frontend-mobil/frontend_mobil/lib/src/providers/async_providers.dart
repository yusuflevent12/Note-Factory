import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/hierarchy_service.dart';
import '../api/content_service.dart';
import '../models/course_model.dart';
import '../models/content_model.dart';

final hierarchyServiceProvider = Provider<HierarchyService>((ref) {
  return HierarchyService();
});

final contentServiceProvider = Provider<ContentService>((ref) {
  return ContentService();
});

// Courses provider - for a specific department
final coursesProvider = FutureProvider.family<List<CourseModel>, int>(
  (ref, departmentId) async {
    final service = ref.watch(hierarchyServiceProvider);
    return await service.getCourses(departmentId);
  },
);

// Content provider - for a specific course
final contentProvider = FutureProvider.family<List<ContentModel>, int>(
  (ref, courseId) async {
    final service = ref.watch(contentServiceProvider);
    return await service.getContentForCourse(courseId);
  },
);

// Universities provider
final universitiesProvider = FutureProvider<List<UniversityModel>>((ref) async {
  final service = ref.watch(hierarchyServiceProvider);
  return await service.getUniversities();
});

// Faculties provider - for a specific university
final facultiesProvider = FutureProvider.family<List<FacultyModel>, int>(
  (ref, universityId) async {
    final service = ref.watch(hierarchyServiceProvider);
    return await service.getFaculties(universityId);
  },
);

// Departments provider - for a specific faculty
final departmentsProvider = FutureProvider.family<List<DepartmentModel>, int>(
  (ref, facultyId) async {
    final service = ref.watch(hierarchyServiceProvider);
    return await service.getDepartments(facultyId);
  },
);

