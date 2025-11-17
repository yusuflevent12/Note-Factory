import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:frontend_mobil/src/models/content_model.dart';
import 'package:frontend_mobil/src/core/constants.dart';

class ContentViewScreen extends StatefulWidget {
  final Content content;

  const ContentViewScreen({super.key, required this.content});

  @override
  _ContentViewScreenState createState() => _ContentViewScreenState();
}

class _ContentViewScreenState extends State<ContentViewScreen> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    // Use the fileUrl from the content object
    final fullUrl = '${AppConstants.apiBaseUrl}${widget.content.fileUrl}';
    downloadFile(fullUrl).then((path) {
      setState(() {
        pdfPath = path;
      });
    });
  }

  Future<String> downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/${widget.content.id}.pdf');
        await file.writeAsBytes(bytes, flush: true);
        return file.path;
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      print('Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dosya indirilemedi: $url')),
      );
      return ''; // Return empty path on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.content.title),
      ),
      body: pdfPath != null && pdfPath!.isNotEmpty
          ? PDFView(
              filePath: pdfPath,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // Beğenme mantığı eklenecek
              },
              icon: const Icon(Icons.thumb_up),
            ),
            IconButton(
              onPressed: () {
                // Beğenmeme mantığı eklenecek
              },
              icon: const Icon(Icons.thumb_down),
            ),
            TextButton(
              onPressed: () {
                // Yorumlar bölümünü açma mantığı eklenecek
              },
              child: const Text('Yorumlar'),
            ),
          ],
        ),
      ),
    );
  }
}
