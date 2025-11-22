import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_mobil/src/providers/async_providers.dart';
import 'package:frontend_mobil/src/widgets/common/loading_spinner.dart';
import 'package:frontend_mobil/src/widgets/content_card.dart';
import 'package:go_router/go_router.dart';

class CourseDetailScreen extends ConsumerWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kurs detaylarını izle
    final courseDetailAsyncValue = ref.watch(courseDetailProvider(courseId));

    return Scaffold(
      appBar: AppBar(
        // Başlığı kurs verisine göre ayarla
        title: courseDetailAsyncValue.when(
          data: (course) => Text(course.name),
          loading: () => const Text('Yükleniyor...'),
          error: (err, stack) => const Text('Hata'),
        ),
      ),
      body: courseDetailAsyncValue.when(
        data: (course) {
          // Kurs yüklendiyse, içerikleri izle
          final contentsAsyncValue = ref.watch(courseContentsProvider(courseId));
          return contentsAsyncValue.when(
            data: (contents) {
              if (contents.isEmpty) {
                return const Center(
                    child: Text('Bu kurs için içerik bulunamadı.'));
              }
              // İçerikleri liste olarak göster
              return ListView.builder(
                itemCount: contents.length,
                itemBuilder: (context, index) {
                  final content = contents[index];
                  return ContentCard(
                    content: content,
                    onTap: () {
                      context.goNamed(
                        'content-view', // Corrected route name from 'contentView' to 'content-view'
                        pathParameters: {
                          'courseId': courseId,
                          'contentId': content.id.toString(),
                        },
                        queryParameters: {
                          'courseId': courseId,
                        },
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: LoadingSpinner()),
            error: (err, stack) =>
                Center(child: Text('İçerik yüklenemedi: $err')),
          );
        },
        loading: () => const Center(child: LoadingSpinner()),
        error: (err, stack) =>
            Center(child: Text('Kurs yüklenemedi: $err')),
      ),
    );
  }
}