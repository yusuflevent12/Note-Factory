import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import '../api/content_service.dart';
import '../api/dio_client.dart';
import '../models/content_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:io' as io; // REMOVED for Web compatibility

class ContentViewScreen extends ConsumerStatefulWidget {
  final int contentId;
  final int? courseId;

  const ContentViewScreen({
    super.key,
    required this.contentId,
    this.courseId,
  });

  @override
  ConsumerState<ContentViewScreen> createState() => _ContentViewScreenState();
}

class _ContentViewScreenState extends ConsumerState<ContentViewScreen> {
  ContentModel? _content;
  bool _isLoading = true;
  String? _error;
  String? _localFilePath;
  // PDFViewController? _pdfViewController;
  final int _currentPage = 0;
  final int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    if (widget.courseId == null) {
      setState(() {
        _isLoading = false;
        _error = 'Course ID bulunamadı';
      });
      return;
    }

    try {
      final contentService = ContentService();
      // Geçici çözüm: Course'dan tüm içerikleri çek ve ID'ye göre filtrele
      // Backend'e /content/{content_id} endpoint'i eklenmeli
      final contents = await contentService.getContentForCourse(widget.courseId!);
      final content = contents.firstWhere(
        (c) => c.id == widget.contentId,
        orElse: () => throw Exception('İçerik bulunamadı'),
      );

      setState(() {
        _content = content;
      });

      // PDF'i yükle
      if (!kIsWeb) {
        await _loadPdf(content.fileUrl);
      } else {
         setState(() {
          _isLoading = false;
        });
      }
      
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _loadPdf(String fileUrl) async {
    try {
      /*
      final contentService = ContentService();
      final dio = DioClient().dio;
      final url = contentService.getContentUrl(fileUrl);
      
      // PDF'i geçici dizine indir (sadece görüntüleme için, kullanıcı indiremez)
      final tempDir = await getTemporaryDirectory();
      final fileName = fileUrl.split('/').last;
      final localFile = io.File('${tempDir.path}/$fileName');

      await dio.download(url, localFile.path);

      if (mounted) {
        setState(() {
          _localFilePath = localFile.path;
          _isLoading = false;
        });
      }
      */
      // Placeholder for mobile implementation
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = "PDF görüntüleme şu an devre dışı.";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'PDF yüklenirken hata oluştu: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hata'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(_error!),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _content != null
            ? Text(_content!.title)
            : const Text('İçerik'),
      ),
      body: Center(
        child: kIsWeb 
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('PDF görüntüleme web üzerinde henüz desteklenmemektedir.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: İndirme veya yeni sekmede açma
                  }, 
                  child: const Text('İndir / Aç')
                )
              ],
            )
          : const Text('PDF Görüntüleyici Devre Dışı (Web Uyumluluğu İçin)'),
      ),
      bottomNavigationBar: _content != null
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Beğeni özelliği yakında eklenecek'),
                        ),
                      );
                    },
                  ),
                  Text('${_content!.upvoteCount}'),
                  IconButton(
                    icon: const Icon(Icons.thumb_down),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Beğenmeme özelliği yakında eklenecek'),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Yorumlar özelliği yakında eklenecek'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

