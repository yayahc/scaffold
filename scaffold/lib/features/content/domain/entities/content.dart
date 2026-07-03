import 'package:equatable/equatable.dart';

import 'content_type.dart';

class Content extends Equatable {
  const Content({
    required this.id,
    required this.type,
    required this.title,
    required this.published,
    required this.locked,
    required this.payload,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.coverImage,
    this.unlockCode,
  });

  final String id;
  final ContentType type;
  final String title;
  final String? description;
  final String? coverImage;
  final bool published;

  final bool locked;
  final String? unlockCode;

  final Map<String, dynamic> payload;

  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [id, type, title, published, locked, updatedAt];
}
