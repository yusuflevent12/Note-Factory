import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';

import '../api/content_service.dart';
import '../providers/async_providers.dart';
import '../models/content_model.dart';
import '../models/course_model.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  ConsumerState<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  
  int? _selectedCourseId;
  ContentType _selectedContentType = ContentType.lectureNote;
  PlatformFile? _selectedFile;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true, // Important for Web to get bytes
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir PDF dosyası seçin'),
        ),
      );
      return;
    }

    if (_selectedCourseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir ders seçin'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final contentService = ContentService();
      await contentService.uploadContent(
        title: _titleController.text,
        contentType: _selectedContentType,
        courseId: _selectedCourseId!,
        file: _selectedFile!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dosya başarıyla yüklendi!'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Yükleme başarısız: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider(1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni İçerik Yükle'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Ders Seçme
                    coursesAsync.when(
                      data: (courses) {
                        if (courses.isEmpty) {
                          return const Text('Henüz ders bulunmuyor');
                        }
                        return DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Ders Seçin',
                            border: OutlineInputBorder(),
                          ),
                          initialValue: _selectedCourseId,
                          items: courses.map((course) {
                            return DropdownMenuItem(
                              value: course.id,
                              child: Text(course.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCourseId = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Lütfen bir ders seçin' : null,
                          );
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stack) => Text(
                        'Ders listesi yüklenemedi: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Başlık
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Başlık',
                        hintText: 'Örn: Vize 1 Çıkmış Soruları',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Lütfen bir başlık girin' : null,
                    ),
                    const SizedBox(height: 16),
                    
                    // İçerik Tipi
                    DropdownButtonFormField<ContentType>(
                      decoration: const InputDecoration(
                        labelText: 'İçerik Tipi',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _selectedContentType,
                      items: ContentType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedContentType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Dosya Seçme
                    OutlinedButton.icon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: Text(
                        _selectedFile == null
                            ? 'PDF Dosyası Seç'
                            : _selectedFile!.name,
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                    if (_selectedFile != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Seçilen dosya: ${_selectedFile!.name}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    
                    // Yükle Butonu
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Yükle',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
