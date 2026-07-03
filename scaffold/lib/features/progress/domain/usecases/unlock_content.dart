import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/content_progress.dart';
import '../repositories/progress_repository.dart';

class UnlockContent implements UseCase<ContentProgress, String> {
  const UnlockContent(this._repository);

  final ProgressRepository _repository;

  @override
  Future<Either<Failure, ContentProgress>> call(String contentId) {
    return _repository.setUnlocked(contentId);
  }
}
