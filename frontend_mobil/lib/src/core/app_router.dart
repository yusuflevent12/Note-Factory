import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_mobil/src/models/content_model.dart';
import 'package:frontend_mobil/src/screens/login_screen.dart';
import 'package:frontend_mobil/src/screens/register_screen.dart';
import 'package:frontend_mobil/src/screens/home_screen.dart';
import 'package:frontend_mobil/src/screens/course_detail_screen.dart';
import 'package:frontend_mobil/src/screens/content_view_screen.dart';
import 'package:frontend_mobil/src/screens/upload_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/course_detail',
        builder: (BuildContext context, GoRouterState state) {
          final courseId = state.extra as int;
          return CourseDetailScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/content_view',
        builder: (BuildContext context, GoRouterState state) {
          final content = state.extra as Content; // Get the content object
          return ContentViewScreen(content: content); // Pass it to the screen
        },
      ),
      GoRoute(
        path: '/upload',
        builder: (BuildContext context, GoRouterState state) {
          return const UploadScreen();
        },
      ),
    ],
  );
}
