import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/content.dart';
import '../repositories/content_repository.dart';

@lazySingleton
class GetContentById implements UseCase<Content, String> {
  const GetContentById(this._repository);

  final ContentRepository _repository;

  @override
  Future<Either<Failure, Content>> call(String id) {
    return _repository.getContentById(id);
  }
}
