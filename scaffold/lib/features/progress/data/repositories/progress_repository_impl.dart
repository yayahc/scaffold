import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/content_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_local_datasource.dart';
import '../models/content_progress_model.dart';

/// Read-modify-write over the local datasource. Owns the merge rules
/// (e.g. best-score-wins) so the datasource stays a dumb key/value store.
class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this._local);

  final ProgressLocalDataSource _local;

  @override
  Future<Either<Failure, Map<String, ContentProgress>>> getAll() async {
    try {
      final all = await _local.readAll();
      return Right(all);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ContentProgress>> getForContent(
    String contentId,
  ) async {
    try {
      final all = await _local.readAll();
      return Right(all[contentId] ?? ContentProgress.initial(contentId));
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ContentProgress>> setUnlocked(
    String contentId,
  ) async {
    return _mutate(contentId, (current) => current.copyWith(unlocked: true));
  }

  @override
  Future<Either<Failure, ContentProgress>> recordAttempt({
    required String contentId,
    required double score,
    required DateTime attemptedAt,
  }) async {
    return _mutate(contentId, (current) {
      final best = (current.bestScore == null || score > current.bestScore!)
          ? score
          : current.bestScore;
      return current.copyWith(
        completed: true,
        bestScore: best,
        lastAttemptAt: attemptedAt,
      );
    });
  }

  /// Loads current progress, applies [update], persists, and returns the result.
  Future<Either<Failure, ContentProgress>> _mutate(
    String contentId,
    ContentProgress Function(ContentProgress current) update,
  ) async {
    try {
      final all = await _local.readAll();
      final current = all[contentId] ?? ContentProgress.initial(contentId);
      final next = update(current);
      await _local.write(ContentProgressModel.fromEntity(next));
      return Right(next);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    }
  }
}
