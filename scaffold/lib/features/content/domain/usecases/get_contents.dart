import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/content.dart';
import '../repositories/content_repository.dart';

@lazySingleton
class GetContents implements UseCase<List<Content>, NoParams> {
  const GetContents(this._repository);

  final ContentRepository _repository;

  @override
  Future<Either<Failure, List<Content>>> call(NoParams params) {
    return _repository.getContents();
  }
}
