import 'user_model.dart';

enum ContentType {
  lectureNote,
  pastExam,
  slide,
}

extension ContentTypeExtension on ContentType {
  String get value {
    switch (this) {
      case ContentType.lectureNote:
        return 'lecture_note';
      case ContentType.pastExam:
        return 'past_exam';
      case ContentType.slide:
        return 'slide';
    }
  }

  String get displayName {
    switch (this) {
      case ContentType.lectureNote:
        return 'NOT';
      case ContentType.pastExam:
        return 'ÇIKMIŞ SORU';
      case ContentType.slide:
        return 'SLAYT';
    }
  }

  static ContentType fromString(String value) {
    switch (value) {
      case 'lecture_note':
        return ContentType.lectureNote;
      case 'past_exam':
        return ContentType.pastExam;
      case 'slide':
        return ContentType.slide;
      default:
        return ContentType.lectureNote;
    }
  }
}

class VoteModel {
  final int id;
  final int value; // -1 for downvote, 1 for upvote
  final UserModel owner;

  VoteModel({
    required this.id,
    required this.value,
    required this.owner,
  });

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
      id: json['id'] as int,
      value: json['value'] as int,
      owner: UserModel.fromJson(json['owner'] as Map<String, dynamic>),
    );
  }
}

class CommentModel {
  final int id;
  final String text;
  final UserModel owner;

  CommentModel({
    required this.id,
    required this.text,
    required this.owner,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as int,
      text: json['text'] as String,
      owner: UserModel.fromJson(json['owner'] as Map<String, dynamic>),
    );
  }
}

class ContentModel {
  final int id;
  final String title;
  final String? description;
  final ContentType contentType;
  final String filePath;
  final UserModel owner;
  final List<CommentModel> comments;
  final List<VoteModel> votes;

  ContentModel({
    required this.id,
    required this.title,
    this.description,
    required this.contentType,
    required this.filePath,
    required this.owner,
    this.comments = const [],
    this.votes = const [],
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      contentType: ContentTypeExtension.fromString(
        json['content_type'] as String,
      ),
      filePath: json['file_path'] as String,
      owner: UserModel.fromJson(json['owner'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      votes: (json['votes'] as List<dynamic>?)
              ?.map((e) => VoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  int get upvoteCount {
    return votes.where((v) => v.value == 1).length;
  }

  int get downvoteCount {
    return votes.where((v) => v.value == -1).length;
  }

  int get netVotes {
    return upvoteCount - downvoteCount;
  }
}

