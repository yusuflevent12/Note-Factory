import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_mobil/src/providers/async_providers.dart';
import 'package:frontend_mobil/src/widgets/common/loading_spinner.dart';
import 'package:frontend_mobil/src/widgets/content_card.dart';
import 'package:go_router/go_router.dart';

// Sayfa içi durum (state) yönetimine gerek kalmadığı için
// ConsumerStatefulWidget'tan ConsumerWidget'a dönüştürüldü.
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
          data: (course) => Text(course.title),
          loading: () => const Text('Yükleniyor...'),
          error: (err, stack) => const Text('Hata'),
        ),
        // Özel geri tuşuna gerek yok, GoRouter bunu halleder.
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
                      // Burası GÜNCELLENDİ:
                      // Tıklandığında artık sayfa içi state ayarlamak yerine
                      // GoRouter ile 'contentView' rotasına yönlendirme yapılıyor.
                      context.goNamed(
                        'contentView',
                        pathParameters: {
                          'courseId': courseId,
                          'contentId': content.id,
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