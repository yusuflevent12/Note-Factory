import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_mobil/src/providers/async_providers.dart';
import 'package:frontend_mobil/src/widgets/content_card.dart';
import 'package:frontend_mobil/src/widgets/common/LoadingSpinner.dart';

class CourseDetailScreen extends ConsumerWidget {
  final int courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsyncValue = ref.watch(contentForCourseProvider(courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ders Detayı'),
      ),
      body: contentAsyncValue.when(
        data: (contents) {
          return ListView.builder(
            itemCount: contents.length,
            itemBuilder: (context, index) {
              final content = contents[index];
              return ContentCard(
                content: content,
                onTap: () {
                  // Pass the whole content object to the content view screen
                  context.go('/content_view', extra: content);
                },
              );
            },
          );
        },
        loading: () => const LoadingSpinner(),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
    );
  }
}
