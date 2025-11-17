import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:frontend_mobil/src/models/content_model.dart';
import 'package:frontend_mobil/src/providers/async_providers.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  ContentType _contentType = ContentType.note;
  File? _file;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _file != null) {
      _formKey.currentState!.save();
      // Burada courseId'yi sabit kodluyoruz, gerçek bir uygulamada
      // kullanıcının seçmesi için bir yol olmalıdır.
      ref.read(contentServiceProvider).createContent(
            title: _title!,
            description: _description,
            contentType: _contentType,
            courseId: 1,
            file: _file!,
          ).then((content) {
            if (content != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('İçerik başarıyla yüklendi!')),
              );
              // Refresh the content list
              ref.refresh(contentForCourseProvider(1));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('İçerik yüklenemedi.')),
              );
            }
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun ve bir dosya seçin.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İçerik Yükle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Başlık'),
                onSaved: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir başlık girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Açıklama'),
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<ContentType>(
                value: _contentType,
                decoration: const InputDecoration(labelText: 'İçerik Türü'),
                items: ContentType.values.map((ContentType type) {
                  return DropdownMenuItem<ContentType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (ContentType? newValue) {
                  setState(() {
                    _contentType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: Text(_file == null ? 'Dosya Seç' : _file!.path.split('/').last),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Yükle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
