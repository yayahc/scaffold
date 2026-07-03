import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/content_progress.dart';
import '../repositories/progress_repository.dart';

@lazySingleton
class RecordQuizAttempt
    implements UseCase<ContentProgress, RecordQuizAttemptParams> {
  const RecordQuizAttempt(this._repository);

  final ProgressRepository _repository;

  @override
  Future<Either<Failure, ContentProgress>> call(RecordQuizAttemptParams p) {
    return _repository.recordAttempt(
      contentId: p.contentId,
      score: p.score,
      attemptedAt: p.attemptedAt,
    );
  }
}

class RecordQuizAttemptParams extends Equatable {
  const RecordQuizAttemptParams({
    required this.contentId,
    required this.score,
    required this.attemptedAt,
  });

  final String contentId;
  final double score;
  final DateTime attemptedAt;

  @override
  List<Object?> get props => [contentId, score, attemptedAt];
}
