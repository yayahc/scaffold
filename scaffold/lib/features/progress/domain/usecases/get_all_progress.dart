import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/content_progress.dart';
import '../repositories/progress_repository.dart';

@lazySingleton
class GetAllProgress
    implements UseCase<Map<String, ContentProgress>, NoParams> {
  const GetAllProgress(this._repository);

  final ProgressRepository _repository;

  @override
  Future<Either<Failure, Map<String, ContentProgress>>> call(NoParams params) {
    return _repository.getAll();
  }
}
