import 'package:go_router/go_router.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/course_detail_screen.dart';
import '../screens/content_view_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/course/:courseId',
      name: 'course-detail',
      builder: (context, state) {
        final courseId = int.parse(state.pathParameters['courseId']!);
        return CourseDetailScreen(courseId: courseId);
      },
    ),
    GoRoute(
      path: '/content/:contentId',
      name: 'content-view',
      builder: (context, state) {
        final contentId = int.parse(state.pathParameters['contentId']!);
        final courseId = state.uri.queryParameters['courseId'];
        return ContentViewScreen(
          contentId: contentId,
          courseId: courseId != null ? int.parse(courseId) : null,
        );
      },
    ),
  ],
);

