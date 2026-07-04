import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/content.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/content_local_datasource.dart';
import '../datasources/content_remote_datasource.dart';

@LazySingleton(as: ContentRepository)
class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._remote, this._local);

  final ContentRemoteDataSource _remote;
  final ContentLocalDataSource _local;

  @override
  Future<Either<Failure, List<Content>>> getContents() async {
    try {
      final cached = await _local.readContents();
      if (cached != null) return Right(cached);
      return _fetchAndCache();
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Content>>> refreshContents() async {
    try {
      return _fetchAndCache();
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Content>>> _fetchAndCache() async {
    final contents = await _remote.getContents();
    await _local.writeContents(contents);
    return Right(contents);
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
