import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/content.dart';

abstract interface class ContentRepository {
  Future<Either<Failure, List<Content>>> getContents();
  Future<Either<Failure, List<Content>>> refreshContents();
  Future<Either<Failure, Content>> getContentById(String id);
}
