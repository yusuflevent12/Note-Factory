enum ContentType {
  slide,
  note,
  exam,
}

class Content {
  final int id;
  final String title;
  final ContentType type;
  final int upvotes;
  final String fileUrl;

  Content({
    required this.id,
    required this.title,
    required this.type,
    required this.upvotes,
    required this.fileUrl,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      title: json['title'],
      type: ContentType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => ContentType.note,
      ),
      upvotes: json['upvotes'],
      fileUrl: json['file_url'],
    );
  }
}
