import '../../domain/entities/content_progress.dart';

/// JSON-serializable form of [ContentProgress] for local storage.
class ContentProgressModel extends ContentProgress {
  const ContentProgressModel({
    required super.contentId,
    super.unlocked,
    super.completed,
    super.bestScore,
    super.lastAttemptAt,
  });

  factory ContentProgressModel.fromEntity(ContentProgress p) =>
      ContentProgressModel(
        contentId: p.contentId,
        unlocked: p.unlocked,
        completed: p.completed,
        bestScore: p.bestScore,
        lastAttemptAt: p.lastAttemptAt,
      );

  factory ContentProgressModel.fromJson(
    String contentId,
    Map<String, dynamic> json,
  ) {
    final ts = json['lastAttemptAt'] as String?;
    return ContentProgressModel(
      contentId: contentId,
      unlocked: json['unlocked'] as bool? ?? false,
      completed: json['completed'] as bool? ?? false,
      bestScore: (json['bestScore'] as num?)?.toDouble(),
      lastAttemptAt: ts == null ? null : DateTime.parse(ts),
    );
  }

  Map<String, dynamic> toJson() => {
        'unlocked': unlocked,
        'completed': completed,
        if (bestScore != null) 'bestScore': bestScore,
        if (lastAttemptAt != null)
          'lastAttemptAt': lastAttemptAt!.toIso8601String(),
      };
}
