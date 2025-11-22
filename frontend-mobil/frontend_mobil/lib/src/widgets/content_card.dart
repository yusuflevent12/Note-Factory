import 'package:flutter/material.dart';
import '../models/content_model.dart';

class ContentCard extends StatelessWidget {
  final ContentModel content;
  final VoidCallback? onTap;

  const ContentCard({super.key, required this.content, this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = content.title;
    final description = content.description ?? '';
    final votes = content.netVotes;

    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: Text(description),
      trailing: Text('$votes'),
    );
  }
}