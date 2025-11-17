import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../providers/async_providers.dart';
import '../models/course_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // TODO: Bu ekranda şu an için sadece örnek dersler gösteriliyor
    // Gerçek uygulamada, kullanıcının seçtiği üniversite/bölüm/dersler gösterilmeli
    // Şimdilik hardcoded bir department ID kullanıyoruz (örnek: 1)
    final coursesAsync = ref.watch(coursesProvider(1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Erciyes Yazılım'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            tooltip: 'Çıkış Yap',
          ),
        ],
      ),
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return const Center(
              child: Text('Henüz ders bulunmuyor'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return _CourseCard(course: course);
            },
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
                'Dersler yüklenirken hata oluştu',
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
                  ref.invalidate(coursesProvider(1));
                },
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: İçerik yükleme ekranını aç
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('İçerik yükleme özelliği yakında eklenecek'),
            ),
          );
        },
        tooltip: 'İçerik Yükle',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseModel course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: course.courseCode != null
            ? Text('[${course.courseCode}]')
            : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.go('/course/${course.id}');
        },
      ),
    );
  }
}

