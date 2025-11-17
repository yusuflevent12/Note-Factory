import 'package:flutter/material.dart';
import '../models/content_model.dart';

class ContentCard extends StatelessWidget {
  final ContentModel content;
  final VoidCallback onTap;

  const ContentCard({
    super.key,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Content Type Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getTypeColor(content.contentType),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  content.contentType.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (content.description != null &&
                        content.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        content.description!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Vote Count
              Column(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 20,
                  ),
                  Text(
                    '${content.netVotes}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(ContentType type) {
    switch (type) {
      case ContentType.lectureNote:
        return Colors.blue;
      case ContentType.pastExam:
        return Colors.orange;
      case ContentType.slide:
        return Colors.purple;
    }
  }
}

