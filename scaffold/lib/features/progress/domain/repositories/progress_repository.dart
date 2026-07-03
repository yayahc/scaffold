import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/content_progress.dart';

abstract interface class ProgressRepository {
  Future<Either<Failure, Map<String, ContentProgress>>> getAll();

  Future<Either<Failure, ContentProgress>> getForContent(String contentId);

  Future<Either<Failure, ContentProgress>> setUnlocked(String contentId);

  Future<Either<Failure, ContentProgress>> recordAttempt({
    required String contentId,
    required double score,
    required DateTime attemptedAt,
  });
}
