import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/content.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/content_remote_datasource.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._remote);

  final ContentRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Content>>> getContents() async {
    try {
      final contents = await _remote.getContents();
      return Right(contents);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Content>> getContentById(String id) async {
    try {
      final content = await _remote.getContentById(id);
      return Right(content);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
