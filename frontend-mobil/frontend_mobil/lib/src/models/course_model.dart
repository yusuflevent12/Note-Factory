class CourseModel {
  final int id;
  final String name;
  final String? courseCode;
  final int departmentId;

  CourseModel({
    required this.id,
    required this.name,
    this.courseCode,
    required this.departmentId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      courseCode: json['course_code'] as String?,
      departmentId: json['department_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course_code': courseCode,
      'department_id': departmentId,
    };
  }
}

class DepartmentModel {
  final int id;
  final String name;
  final int facultyId;
  final List<CourseModel> courses;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.facultyId,
    this.courses = const [],
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      facultyId: json['faculty_id'] as int,
      courses: (json['departments'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class FacultyModel {
  final int id;
  final String name;
  final int universityId;
  final List<DepartmentModel> departments;

  FacultyModel({
    required this.id,
    required this.name,
    required this.universityId,
    this.departments = const [],
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'] as int,
      name: json['name'] as String,
      universityId: json['university_id'] as int,
      departments: (json['departments'] as List<dynamic>?)
              ?.map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class UniversityModel {
  final int id;
  final String name;
  final List<FacultyModel> faculties;

  UniversityModel({
    required this.id,
    required this.name,
    this.faculties = const [],
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'] as int,
      name: json['name'] as String,
      faculties: (json['faculties'] as List<dynamic>?)
              ?.map((e) => FacultyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

