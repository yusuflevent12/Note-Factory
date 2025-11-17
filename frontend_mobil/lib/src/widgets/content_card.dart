import 'package:flutter/material.dart';
import 'package:frontend_mobil/src/models/content_model.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  final VoidCallback onTap;

  const ContentCard({
    super.key,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(content.title),
        subtitle: Text('[${content.type.toString().split('.').last.toUpperCase()}]'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_upward),
            const SizedBox(width: 4),
            Text(content.upvotes.toString()),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
