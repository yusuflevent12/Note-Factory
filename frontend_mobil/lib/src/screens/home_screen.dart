import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_mobil/src/providers/async_providers.dart';
import 'package:frontend_mobil/src/widgets/common/LoadingSpinner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsyncValue = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Erciyes Yazılım'),
      ),
      body: coursesAsyncValue.when(
        data: (courses) {
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                child: ListTile(
                  title: Text(course.name),
                  subtitle: Text(course.code),
                  onTap: () {
                    context.go('/course_detail', extra: course.id);
                  },
                ),
              );
            },
          );
        },
        loading: () => const LoadingSpinner(),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/upload'); // Navigate to the upload screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
