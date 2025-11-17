import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/async_providers.dart';
import '../widgets/content_card.dart';

class CourseDetailScreen extends ConsumerWidget {
  final int courseId;

  const CourseDetailScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync = ref.watch(contentProvider(courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ders İçerikleri'),
      ),
      body: contentAsync.when(
        data: (contents) {
          if (contents.isEmpty) {
            return const Center(
              child: Text('Bu derse ait içerik bulunmuyor'),
            );
          }

          // İçerikleri oy sayısına göre sırala (en yüksek oy alan en üstte)
          contents.sort((a, b) => b.netVotes.compareTo(a.netVotes));

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(contentProvider(courseId));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: contents.length,
              itemBuilder: (context, index) {
                final content = contents[index];
                return ContentCard(
                  content: content,
                  onTap: () {
                    context.go('/content/${content.id}?courseId=$courseId');
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'İçerikler yüklenirken hata oluştu',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(contentProvider(courseId));
                },
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

