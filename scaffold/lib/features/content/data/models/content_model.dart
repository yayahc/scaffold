import 'dart:convert';

import '../../domain/entities/content.dart';
import '../../domain/entities/content_type.dart';

class ContentModel extends Content {
  const ContentModel({
    required super.id,
    required super.type,
    required super.title,
    required super.published,
    required super.locked,
    required super.payload,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.coverImage,
    super.unlockCode,
  });

  factory ContentModel.fromRow(Map<String, dynamic> row) {
    final rawPayload = row['payload'];
    return ContentModel(
      id: row['id'].toString(),
      type: ContentType.fromString(row['type'] as String),
      title: row['title'] as String,
      description: row['description'] as String?,
      coverImage: row['cover_image'] as String?,
      published: row['published'] as bool,
      locked: row['locked'] as bool,
      unlockCode: row['unlock_code'] as String?,
      payload: switch (rawPayload) {
        final Map<String, dynamic> m => m,
        final String s => jsonDecode(s) as Map<String, dynamic>,
        _ => const <String, dynamic>{},
      },
      createdAt: row['created_at'] as DateTime,
      updatedAt: row['updated_at'] as DateTime,
    );
  }
}
