import 'package:equatable/equatable.dart';

class ContentProgress extends Equatable {
  const ContentProgress({
    required this.contentId,
    this.unlocked = false,
    this.completed = false,
    this.bestScore,
    this.lastAttemptAt,
  });

  final String contentId;

  final bool unlocked;

  final bool completed;

  final double? bestScore;

  final DateTime? lastAttemptAt;

  factory ContentProgress.initial(String contentId) =>
      ContentProgress(contentId: contentId);

  ContentProgress copyWith({
    bool? unlocked,
    bool? completed,
    double? bestScore,
    DateTime? lastAttemptAt,
  }) {
    return ContentProgress(
      contentId: contentId,
      unlocked: unlocked ?? this.unlocked,
      completed: completed ?? this.completed,
      bestScore: bestScore ?? this.bestScore,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }

  @override
  List<Object?> get props =>
      [contentId, unlocked, completed, bestScore, lastAttemptAt];
}
