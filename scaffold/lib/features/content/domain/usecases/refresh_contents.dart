import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/content.dart';
import '../repositories/content_repository.dart';

@lazySingleton
class RefreshContents implements UseCase<List<Content>, NoParams> {
  const RefreshContents(this._repository);

  final ContentRepository _repository;

  @override
  Future<Either<Failure, List<Content>>> call(NoParams params) {
    return _repository.refreshContents();
  }
}
